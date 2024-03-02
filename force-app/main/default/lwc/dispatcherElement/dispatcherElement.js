import { publish, subscribe, unsubscribe, APPLICATION_SCOPE, createMessageContext } from "lightning/messageService";
import DispatcherResponseLMS from '@salesforce/messageChannel/DispatcherResponse__c';
import UtilityToast from 'c/utilityToast';

export default class DispatcherElement {
    REQUEST_NAME;
    methods =[];
    dispatcherMessageContext = createMessageContext();

    requestData(method,identifier){
        console.log('calling requestData');
        let response;
        if(!response) {
            this.callout(method,identifier);
        } else{
            console.log('no callout');
        }
    }

    callout(methodName,identifier){
        console.log('calling callout->'+JSON.stringify(methodName)+'iden'+JSON.stringify(identifier));
        var method = this.methods[methodName];
        if(method){
            console.log('callout method:::'+JSON.stringify(method));
            method(identifier)
            .then((response)=>{
                console.log('callout response:::'+JSON.stringify(response));
                this.handleCallback(response);
            })
            .catch((error)=>{
                 // incase of callout error ,publish error to display toast
                    const title = `Loading ${this.REQUEST_NAME} data failed`;
                    const message = error.body ? error.body.message : error.message;
                    UtilityToast.publishToast('error', title, message);
            })
        } else {
            console.log('no method found');
        }

    }
    handleCallback(response){
        console.log('handleCallback');
        this.publishResponse(response);
    }
    publishResponse(response) {
        console.log('callout response:::'+JSON.stringify(response));
        publish(this.dispatcherMessageContext, DispatcherResponseLMS, response)
    }
}