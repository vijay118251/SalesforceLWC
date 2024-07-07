import { LightningElement, api, wire, track } from 'lwc';
import publishContacts from '@salesforce/messageChannel/publishContacts__c';
import subscribeContacts from '@salesforce/messageChannel/subscribeContacts__c';
import {publish,subscribe, MessageContext} from 'lightning/messageService'
export default class AccountIdPublisher extends LightningElement {

    message;
    showContacts = false;
    subscription = null;
    @api recordId;
    @wire(MessageContext)
    messageContext;
    @track contacts = [];

    handleClick(){
        let message = {accountId : this.recordId};
        publish(this.messageContext, publishContacts, message);
    }

    connectedCallback() {
        this.handleSubscribe();
    }
 
    handleSubscribe() {
        if (this.subscription) {
            return;
        }
        
        this.subscription = subscribe(this.messageContext, subscribeContacts, (result) => {
        this.showMessage(result);
        });
    }
    showMessage(result){
        this.contacts = result.contacts;
        this.showContacts = this.contacts?true:false;
        console.log('message in subscriber after-->', this.contacts);
    }

}