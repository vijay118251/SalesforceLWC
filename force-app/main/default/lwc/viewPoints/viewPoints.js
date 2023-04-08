import { LightningElement,api,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import selectFromAccId from '@salesforce/apex/PointsElementController.selectFromAccId';
const columnList = [{
                    label: 'Name',
                    fieldName: 'fullname',
                    wrapText: true
                },
				{
                    label: 'Entity Number',
                    fieldName: 'entityId',
                    wrapText: true
                },
                {
                   label: 'Age',
                    fieldName: 'age',
                    wrapText: true
                },
                {
                    label: 'Date of Birth',
                    fieldName: 'dateOfBirth',
                    wrapText: true
                },
                {
                    label: 'Gender',
                    fieldName: 'gender',
                    wrapText: true
                }
				];
export default class ViewPoints extends LightningElement {

    recId;
    pointDetails=[];
    planType='Wellness';
    error;
    enablePointsDetails = false;
    planDetails = {};
    familyDetails=[];
    showContainer=false;
    columnList=columnList;
    familyList=[];
    data=[];
    
    // get record ID from current page reference
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(JSON.stringify(currentPageReference));
        this.recId  = currentPageReference.state.c__recId?currentPageReference.state.c__recId:'';
        console.log(this.recId);
    }

    /* lwc connected callback lifecycle hook method */
    connectedCallback() {
        this.firePointsRequest();
    }

    /* fire request */
    firePointsRequest() {
        selectFromAccId({accId:this.recId})
            .then((response) => {
                this.publishResponse(response)   
            }).catch((err) => {
                this.error = err;
            });
    }

    /* handle response */
    publishResponse(response) {
        if(response.command.method == 'selectFromAccId') {
            this.processPointsResponse(response);
        }
    }

    /* process response */
    processPointsResponse(response) {
        this.pointDetails = response.details;
        this.enablePointsDetails = true;
        console.log('points response-->',JSON.stringify(this.pointDetails));
        this.handleResponse();
    }

    handleResponse() {
        if(this.pointDetails && this.pointDetails.length) {
            this.pointDetails.forEach(plan => {
                if(plan.planType === this.planType) {
                    this.planDetails.planCode = plan.planCode;
                    this.planDetails.planStartDate = plan.planStartDate;
                    this.planDetails.previousRenewalDate = plan.previousRenewalDate;
                    this.planDetails.renewalDate = plan.renewalDate;
                    this.planDetails.vitalityPlanId = plan.vitalityPlanId;
                    this.planDetails.planType = plan.planType;
                }
                this.familyDetails = plan.familyMembers;
            });
                console.log('plan response-->',JSON.stringify(this.planDetails));
                console.log('family response-->',JSON.stringify(this.familyDetails));
                this.showContainer = true;
                this.handleFamilyName();
        }
    }
    handleFamilyName() {
        this.familyList = [...this.familyDetails].map(item => {
                        return {...item,fullname:item.name.forename+' '+item.name.surname};
                });
        console.log('familyList-->',JSON.stringify(this.familyList));
        this.processFamilyResponse(this.familyDetails);
    }

}