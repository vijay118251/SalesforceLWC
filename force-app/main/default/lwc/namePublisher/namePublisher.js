import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccounts from '@salesforce/apex/TestClass.getAccounts';
import {publish, MessageContext} from 'lightning/messageService';
import myMessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';

export default class NamePublisher extends NavigationMixin(LightningElement) {

    @api recordId;
    @wire(MessageContext)
    messageContext;

    name;

    //property binding in html
    handleChange(event){
        this.name = event.target.value;
    }

    handleClick(){
        const message = {TestChannel : this.name};
        //publish to channel
        // publish(this.messageContext, myMessageChannel, message);
    }

    @wire(getAccounts)
    accounts;

    navigateToAccount(event){
        const accId = event.target.getAttribute('data-id');
        const message = {TestChannel : accId};
        publish(this.messageContext, myMessageChannel, message);
        // console.log('recordId->',accId);
        // this[NavigationMixin.Navigate]({
        //     type: 'standard__recordPage',
        //     attributes: {
        //         recordId: accId,
        //         objectApiName: 'Account',
        //         actionName: 'view'
        //     }
        // });
    }
}