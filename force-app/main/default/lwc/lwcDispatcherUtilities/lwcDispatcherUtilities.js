import { publish, subscribe, unsubscribe, APPLICATION_SCOPE } from 'lightning/messageService';
import DispatcherRequestLMS from '@salesforce/messageChannel/DispatcherRequest__c';
import DispatcherResponseLMS from '@salesforce/messageChannel/DispatcherResponse__c';
import LwcGenerateIdentifierUtil from './lwcGenerateIdentifierUtil';
export default class LwcDispatcherUtilities extends LwcGenerateIdentifierUtil {
    static fireDispatcherRequest(self,method,request) {
        console.log('inside fireDispatcherRequest');
        const name = this.firstName;
        console.log('name::',name);
        const identifier = this.generateIdentifier(self,method,request);
        console.log('identifier',JSON.stringify(identifier));
        const disprequest = {
            method: method,
            request: request,
            identifier: identifier
        };
        console.log('publisher message:::'+JSON.stringify(disprequest)); 
        // publish request data to dispatcher request LMS channel
        publish(self.messageContext, DispatcherRequestLMS, disprequest);   
    }
    
    static subscribeResponseLMS(self) {
        if (!self.subscription) {
        self.subscription = subscribe(
            self.messageContext,
            DispatcherResponseLMS,
            (response) => self.handleResponse(response),
            {scope: APPLICATION_SCOPE}
        );
        }
    }

    static unsubscribeResponseLMS(self) {
        unsubscribe(self.subscription);
        self.subscription=null;
    }

     // check if the request and response parameters match
    static responseMatches(self, requestMethod, requestName, response) {
        if (response.responseName === requestName) {
            return true;
        }
        return false;
    }
}