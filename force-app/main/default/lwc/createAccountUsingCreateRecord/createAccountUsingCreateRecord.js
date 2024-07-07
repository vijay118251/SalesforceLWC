import { LightningElement } from 'lwc';
import {createRecord} from 'lightning/uiRecordApi';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class CreateAccountUsingCreateRecord extends  NavigationMixin(LightningElement) {
    accountId;
    name = '';

    handleNameChange(event){
        this.accountId = undefined;
        this.name = event.target.value;
    }

    handleClick(){
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