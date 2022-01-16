import { LightningElement } from 'lwc';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/SimpleMessageChannel__c";

export default class MsgSubscriber extends LightningElement {
    
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
        this.messageReceived = message.lmsdata.value? message.lmsdata.value:'No msg';
     }
}