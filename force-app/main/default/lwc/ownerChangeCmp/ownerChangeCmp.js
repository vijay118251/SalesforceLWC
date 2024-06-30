import { LightningElement,wire,track } from 'lwc';
import retriveSObjectDetails from '@salesforce/apex/SObjectController.retriveSObjectDetails';
import retriveUserRecords from '@salesforce/apex/SObjectController.retriveUserRecords';
import invokeBatch from '@salesforce/apex/SObjectController.invokeBatch';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
export default class OwnerChangeCmp extends LightningElement {
    objectApiName = 'User';
    userId;
    userName;
    newUserId;
    fields=['Id','SobjectType'];
    userFields=['Id','Name'];
    objectName='ObjectPermissions';
    SobjectResponse=[];
    RetrievedObjectData=[];
    filter = {
        criteria: [
            {
                fieldPath: 'IsActive',
                operator: 'eq',
                value: true,
            },
        ],
    };
    @track successCount;
    @track failureCount;
    @track forceRerender = false;
    selectedObjectId;
    selectedObjectName;
    recordCount;
    showModal=false;
    showChildModal = false;
    isBatchRunning = false;

    get successCounter() {
        return this.successCount>0 ? this.successCount : 0;
    }

    get failureCounter() {
        return this.failureCount>0 ? this.failureCount : 0;
    }

    get options() {
        return this.SobjectResponse;
    }

    constructor() {
        super();
        console.log('Parent Constructor Called');
    }
    connectedCallback() {
        console.log('Parent connectedCallback Called');
        retriveSObjectDetails({ObjectApiName:this.objectName,fields:this.fields})
        .then((response)=> {
            if(response) {
                this.frameOptions(response);
            }
        })
        .catch((err) => {
            console.log('No response found',err);
        });
        // Subscribe to Platform Event
        subscribe('/event/RecordCount__e', -1, this.handleEvent);
    }

    frameOptions(result) {
        this.SobjectResponse=result.map((item) => {
         return {label: item.SobjectType,
            value: item.Id}
        });
        console.log(this.SobjectResponse);
    }

    handleTargetedUser(event) {
        this.userId = event.detail.recordId;
        if(this.userId) {
            retriveSObjectDetails({ObjectApiName:'User',fields:this.userFields})
        .then((response)=> {
            if(response) {
                this.getUserName(response);
            }
        })
        .catch((err) => {
            console.log('No response found',err);
        });
        }   
    }

    getUserName(userData) {
        let findUser = userData.find((user)=>user.Id===this.userId);
        this.userName = findUser.Name;
    }

    handleTargetedObject(event) {
        this.selectedObjectId = event.detail.value;
        let objectName  = this.SobjectResponse.find((item)=>item.value===this.selectedObjectId);
        this.selectedObjectName = objectName.label;
    }

    handleClick(event) {
        this.showModal  = this.checkIfInputsValid();
        if(this.showModal) {
            retriveUserRecords({ObjectApiName:this.selectedObjectName,
                                   fields:['Id','OwnerId','Name'],
                                   ownerID:this.userId})
            .then((response)=> {
                if(response) {
                   this.recordCount = response.length?response.length:0;
                   this.RetrievedObjectData = response;
                }
            })
            .catch((err) => {
                console.log('No response found',err);
            });
        }
        
    }

    closeModal() {
        this.showModal =false;
    }

    checkIfInputsValid() {
        return [...this.template.querySelectorAll('[data-custom]')].reduce(
            (validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            },
            true
        );
    }

    handleTransferUser(event) {
        this.newUserId = event.detail.recordId;
    }

    changeOwnerHandler(event) {
        this.showChildModal=true;
    }

    handleModalEvent(event) {
        this.showChildModal=event.detail.isConfirm;
        this.showModal = event.detail.btnRefVal=='success' ? this.successHandler() : true;
    }

    async successHandler() {
        this.isBatchRunning = true;
        try {
            const result = await invokeBatch({ObjectApiName:this.selectedObjectName,ownerID:this.userId,newOwnerID:this.newUserId});
            if(result) {
            console.log(result);
                // Subscribe to Platform Event
            subscribe('/event/RecordCount__e', -1, (response)=> {
                console.log(JSON.parse(JSON.stringify(response)));
                this.forceRerender = !this.forceRerender;
                this.successCount = response.data.payload.Success_Count__c;
                this.failureCount = response.data.payload.Failure_Count__c;
            });
            }
        } catch(err) {
            console.log(err);
        } finally {
            this.isBatchRunning = false;
        }
        this.showModal = false;
        this.newUserId='';
        this.selectedObjectId='';
        this.refs.recordPicker.clearSelection();
        this.ShowToast('Transfer Records','Records Transfered Successfully', 'success');
    }

    ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    renderedCallback(){
        console.log('Parent renderedCallback Called');
    }

    disconnectedCallback() {
        console.log('Parent Disconnected Callback Called');
    }
}