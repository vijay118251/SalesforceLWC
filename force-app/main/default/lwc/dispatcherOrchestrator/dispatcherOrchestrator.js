import { subscribe, unsubscribe, MessageContext, APPLICATION_SCOPE } from 'lightning/messageService';
import DispatcherRequestLMS from '@salesforce/messageChannel/DispatcherRequest__c';
import { LightningElement,wire } from 'lwc';

export default class DispatcherOrchestrator extends LightningElement {
    elementMap = {};
    subscription = null;
    @wire(MessageContext)
    dispatcherMessageContext;
    // subscribe to dispatcher request   lms channel
    subscribeMC(){
        console.log('calling subscribeMc');
        if (!this.subscription) {
            this.subscription = subscribe(
                this.dispatcherMessageContext,
                DispatcherRequestLMS,
                message => this.handleRequest(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    // this class's purposes is to provide a framework for all orchestrators to be derived from
    handleRequest(message){
        console.log('subscriber message:::'+JSON.stringify(message));  
        const method = message.method;
        const request = message.request;
        const identifier = message.identifier;
        if(request) {
             console.log('elementMap-->'+JSON.stringify(this.elementMap));
            const element = this.elementMap[request];
            console.log('request form:::'+JSON.stringify(element));
            if(element){
                element.requestData(method,identifier);
            } else {
                console.log('no request');
            }
        }
    }

     unsubscribeMC() {
        unsubscribe(this.requestSubscription);
        this.requestSubscription = null;
    }
}