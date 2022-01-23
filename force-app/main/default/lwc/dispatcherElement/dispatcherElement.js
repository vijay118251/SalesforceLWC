import { publish, subscribe, unsubscribe, APPLICATION_SCOPE, createMessageContext } from "lightning/messageService";
import DispatcherResponseLMS from '@salesforce/messageChannel/DispatcherResponse__c';

export default class DispatcherElement {
    REQUEST_NAME;
    methods =[];
    dispatcherMessageContext = createMessageContext();

    requestData(method,identifier){
        let response;
        if(response) {
            this.callout(method,identifier);
        } else{
            console.log('no callout');
        }
    }

    callout(method,identifier){
        var method = this.methods[method];
        if(method){
            method(identifier)
            .then((response)=>{
                this.handleCallback(response);
            })
            .catch((error)=>{
                console.log('error');
            })
        } else {
            console.log('no method found');
        }

    }
    handleCallback(response){
        this.publishResponse(response);
    }
    publishResponse(response) {
        publish(this.dispatcherMessageContext, DispatcherResponseLMS, response)
    }
}