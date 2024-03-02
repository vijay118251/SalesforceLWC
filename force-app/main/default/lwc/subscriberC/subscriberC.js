import { LightningElement,track,wire  } from 'lwc';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC1 from '@salesforce/messageChannel/SampleMessageChannel1__c';
import ResponseMC from '@salesforce/messageChannel/ResponseChannel__c';
import { MessageContext ,publish} from 'lightning/messageService';
import fetchAccountDetails from '@salesforce/apex/AccountManager.fetchAccountDetails';

export default class SubscriberC extends LightningElement {
    
    context = createMessageContext();
    messageReceived;
    accounts={};
    error;
    connectedCallback(){
        this.subscribeMC();
        
    }
    subscribeMC() {
        subscribe(this.context, SAMPLEMC1, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
     }
     handleMessage(message) { 
        console.log('message:::'+JSON.stringify(message));      
        this.messageReceived = message.lms1Data.value? message.lms1Data.value:'No msg';
        console.log(this.messageReceived);
        this.handleSearch();
        this.handleClick();
     }

     @wire(MessageContext)
    messageContext;

    
     handleClick() {
         console.log('running handleclick')
        const payload = {
            lms4Data: {value: this.accounts}
            
        };
        console.log('handleclick method',this.accounts);
        console.log('payload',payload);
        publish(this.messageContext, ResponseMC, payload)

     }
     handleSearch() {
         console.log('handle search running')
        fetchAccountDetails({ accName: this.messageReceived })
            .then((result) => {
                console.log(result);
                this.accounts = result;
                console.log(this.accounts);
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
            });
     }

}