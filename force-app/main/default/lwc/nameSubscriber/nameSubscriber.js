import { LightningElement, wire } from 'lwc';
import {MessageContext, subscribe, unsubscribe} from 'lightning/messageService';
import getAssociatedContacts from '@salesforce/apex/TestClass.getAssociatedContacts';
import myMessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';

export default class NameSubscriber extends LightningElement {

    @wire(MessageContext)
    messageContext;
    contacts;
    error;

    subscription = null;

    recordId;

    connectedCallback() {
        console.log('connectedCallback');
        this.handleSubscribe();
    }

    disconnectedCallback() {
        console.log('disConnectedCallback');
        this.unsubscribeToMessageChannel();
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
        console.log('this.subscription',this.subscription);

    }
 
    handleSubscribe() {
        if (this.subscription) {
            console.log('inside if');
            return;
        }
        console.log('outside if');
        this.subscription = subscribe(this.messageContext, myMessageChannel, (message) => {
        this.showMessage(message);            
        });
        console.log('subscription->',this.subscription);
    }
    showMessage(message){
        this.recordId = message.TestChannel;
    }

    
    //method to get the contacts data
    @wire(getAssociatedContacts, { accId: '$recordId' })
    wiredData({ error, data }) {
      if (data) {
        this.contacts = data;
      } else if (error) {
         this.error = error;
      }
    }
    
}