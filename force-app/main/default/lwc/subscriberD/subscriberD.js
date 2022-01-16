import { LightningElement } from 'lwc';
import SAMPLEMC2 from '@salesforce/messageChannel/SampleMessageChannel2__c';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';

export default class SubscriberD extends LightningElement {
    context = createMessageContext();
    messageReceived;
    connectedCallback(){
        this.subscribeMC();
    }
    subscribeMC() {
        subscribe(this.context, SAMPLEMC2, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
     }
     handleMessage(message) {       
        this.messageReceived = message.lms2Data.value? message.lms2Data.value:'No msg';
     }
}