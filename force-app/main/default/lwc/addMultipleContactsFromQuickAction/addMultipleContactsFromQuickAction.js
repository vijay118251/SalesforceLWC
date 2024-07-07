import { LightningElement, wire, track, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import GENDER_IDENTITY_FIELD from '@salesforce/schema/Contact.GenderIdentity';
import insertContacts from '@salesforce/apex/CreateContacts.insertContacts';
export default class AddMultipleContactsFromQuickAction extends LightningElement {

    firstName;
    lastName;
    email;
    gender;

    @api 
    recordId;

    @track
    contacts = [];

    connectedCallback() {
        this.handleAddRow();
    }

    @wire(getObjectInfo , {objectApiName : CONTACT_OBJECT })
    contact_info;

    @wire(getPicklistValues, {
        recordTypeId : '$contact_info.data.defaultRecordTypeId',
        fieldApiName : GENDER_IDENTITY_FIELD
    })
    genderPicklistValues;

    get getGenderPicklistValues(){
        return this.genderPicklistValues?.data?.values;
    }

    handleAddRow(event){
        this.contacts.push({
            tempId : Date.now()
        })
    }

    handleDeleteRow(event){
        if(this.contacts.length == 1){
            this.showErrorMessage('You cannot delete last contact !!');
            return;
        }
        let tempId = event.target?.dataset.tempId;
        this.contacts = this.contacts.filter(a => a.tempId != tempId);
    }
 
    

    elementChangeHandler(event){
        let contactRow = this.contacts.find(a => a.tempId == event.target.dataset.tempId);
        if(contactRow){
            contactRow[event.target.name] = event.target?.value;
        }
    }

    submitHandler(event){
        const allValid = this.checkFieldsValidity();
        if(allValid){
            this.contacts.forEach(a => a.AccountId = this.recordId);
            console.log('this.contacts : ',this.contacts);
            insertContacts({contacts : this.contacts})
            .then((result) => {
                if(result.isSuccess){
                this.showToast('Contacts saves duccessfully','Success', 'success');
            }
            }).catch((err) => {
                this.showToast('Something went wrong while saving the records',err,'Error');
            });
        }
        else{
            this.showErrorMessage('Please check the below errors..');
        }
    }

    checkFieldsValidity(){
        let isValid = true,
            controls = this.template.querySelectorAll('lightning-input','lightning-combobox');

        controls.forEach(field => {
            if(!field.checkValidity()){
                field.reportValidity();
                this.isValid = false;
            }
        });
        return isValid;
    }
    
    showErrorMessage(message, title = 'Error', variant = 'error'){
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    showToast(message,title,variant){
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}