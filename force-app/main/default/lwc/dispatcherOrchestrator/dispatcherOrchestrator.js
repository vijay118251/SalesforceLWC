
import { subscribe, unsubscribe, MessageContext, APPLICATION_SCOPE } from "lightning/messageService";
import DispatcherRequestLMS from '@salesforce/messageChannel/DispatcherRequest__c';
import { wire } from "lwc";

export default class DispatcherOrchestrator extends LightningElement {
    elementMap = {};
    @wire(MessageContext)
    dispatcherMessageContext;
    subscribeMC(){
        subscribe(this.dispatcherMessageContext, 
            DispatcherRequestLMS, 
            (message) => this.handleRequest(message),
            { scope: APPLICATION_SCOPE});
    }

    handleRequest(message){
        console.log('message:::'+JSON.stringify(message));  
        const method = message.method;
        const request = message.request;
        const identifier = message.identifier;
        if(request) {
            const element = this.elementMap[request];
            if(element){
                element.requestData(method,identifier);
            } else {
                console.log('no request');
            }
        }
    }
}