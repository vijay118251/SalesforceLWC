import { LightningElement } from 'lwc';
import ResponseMC from '@salesforce/messageChannel/ResponseChannel__c';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';

export default class PublisherZ extends LightningElement {
    context = createMessageContext();
    dataReceived;
    connectedCallback(){
        this.subscribeMC();
    }
    subscribeMC() {
        subscribe(this.context, ResponseMC, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
     }
     handleMessage(message) {     
        console.log('message:::'+JSON.stringify(message));  
        this.dataReceived = message.lms4Data.value? message.lms4Data.value:'No msg';
     }
}