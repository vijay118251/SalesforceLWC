import { LightningElement,api,wire,track} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import getFieldDetails from '@salesforce/apex/ReusableFormController.getFieldDetails';
export default class ReUsableForm extends NavigationMixin(LightningElement){

    @api objectName = 'Account';
    @api buttonLabel = 'Create Account';
    @track fieldList;

    @wire(getFieldDetails,{objectAPiName: '$objectName'})
    wiredFieldList({data,error}) {
        if(data) {  
            this.fieldList=data;
        } else if(error) {
            this.fieldList=undefined;   
        }
    }

    handleSuccess(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: this.objectName,
                actionName: 'view'
            },
        });
    }
}