import { publish, subscribe, unsubscribe, APPLICATION_SCOPE } from 'lightning/messageService';
import DispatcherRequestLMS from '@salesforce/messageChannel/DispatcherRequest__c';
import DispatcherResponseLMS from '@salesforce/messageChannel/DispatcherResponse__c';
import LwcGenerateIdentifierUtil from './lwcGenerateIdentifierUtil';
export default class LwcDispatcherUtilities extends LwcGenerateIdentifierUtil {
    static fireDispatcherRequest(self,method,request) {
        console.log('inside fireDispatcherRequest');
        const identifier = this.generateIdentifier(self,method,request);
        const disprequest = {
            method: method,
            request: request,
            identifier: identifier
        };
        console.log('publisher message:::'+JSON.stringify(disprequest));  
         // publish request data to dispatcher request LMS channel
        publish(self.messageContext, DispatcherRequestLMS, disprequest); 
        
    }
    
    /*static subscribeResponseLMS(self) {
        subscribe(
            self.messageContext,
            DispatcherResponseLMS,
            (response) => self.handleResponse(response),
            {scope: APPLICATION_SCOPE}
        );
    }*/
}