import { LightningElement, wire } from 'lwc';
import firstChannel from '@salesforce/messageChannel/firstChannel__c';
import { subscribe, MessageContext } from 'lightning/messageService';
export default class SubscriberComponent extends LightningElement {

    publisherMessage = '';
    subscription = null;
    @wire(MessageContext)
    messageContext;
 
    connectedCallback() {
        this.handleSubscribe();
    }
 
    handleSubscribe() {
        if (this.subscription) {
            return;
        }
        
        this.subscription = subscribe(this.messageContext, firstChannel, (message) => {
        this.showMessage(message);
        console.log('message in handle subscribe-->', message);
            
        });
    }
    showMessage(message){
        console.log('message in subscriber before-->', message);
        this.publisherMessage = message.Text;
        console.log('message in subscriber after-->', message);
    }
    
}