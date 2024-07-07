import { LightningElement, wire, track } from 'lwc';
import publishContacts from '@salesforce/messageChannel/publishContacts__c';
import subscribeContacts from '@salesforce/messageChannel/subscribeContacts__c';
import getAssociatedContacts from '@salesforce/apex/TestClass.getAssociatedContacts'
import {subscribe,publish, MessageContext} from 'lightning/messageService'

export default class AccountIdSubscriber extends LightningElement {

    publisherMessage = '';
    subscription = null;
    @wire(MessageContext)
    messageContext;
    @track contacts = [];
 
    connectedCallback() {
        this.handleSubscribe();
    }
 
    handleSubscribe() {
        if (this.subscription) {
            return;
        }
        
        this.subscription = subscribe(this.messageContext, publishContacts, (message) => {
        this.showMessage(message);

        console.log('message.accountId-->',message.accountId);
            
        });
    }
    showMessage(message){
        this.publisherMessage = message.accountId;

        getAssociatedContacts({accId : message.accountId})
        .then((result) => {
            this.contacts = result;
            this.handlePublish(result);
            console.log('result-->',result);
            console.log('this.contacts-->',JSON.stringify(this.contacts));

        })
        .catch((error) => {
            this.error = error;
        });

        
        console.log('message in subscriber after-->', result);
    }

    handlePublish(result){
        let results = {contacts : result}
        console.log('result in handlePublish-->',results);
        publish(this.messageContext, subscribeContacts, results);
        console.log('result in handlePublish after-->',results);
    }

}