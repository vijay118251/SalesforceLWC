import { LightningElement } from 'lwc';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessageChannel3__c";

export default class LmsNavCompSuB extends LightningElement {
    context = createMessageContext();
    messageReceived;
    connectedCallback(){
        this.subscribeMC();
    }
    subscribeMC() {
        subscribe(this.context, SAMPLEMC, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
     }
     handleMessage(message) {       
        this.messageReceived = message.lms3Data.value? message.lms3Data.value:'No msg';
     }
}