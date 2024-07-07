import {createRecord} from 'lightning/uiRecordApi';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import { LightningElement, api } from 'lwc';
export default class CreateRecordAndUseAsHeadlessQuickAction extends NavigationMixin(LightningElement) {

    // randomString = Math.random().toString(36).substring(2,7);
    name = 'Deepikaaa';
    accountId = undefined;

    @api invoke() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        const recordInput = {apiName : ACCOUNT_OBJECT.objectApiName , fields};
        createRecord(recordInput)
            .then(account => {
                this.accountId = account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title : 'Success',
                        message : 'Account created successfully',
                        variant : 'success'
                    })
                );
                //navigate to account detail page
                this[NavigationMixin.Navigate]({
                    type : 'standard__recordPage',
                    attributes : {
                        objectApiName: 'Account',
                        recordId : this.accountId,
                        actionName : 'view'
                    }
                });
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title : 'Error creating record',
                        message : error.body.message,
                        variant : 'error'
                    })
                )
            });     
    }   
}