import { LightningElement,wire } from 'lwc';
import ACCRESPONSE from '@salesforce/messageChannel/accountInfoChannel__c';
import { MessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';

export default class SubscribeAccountInfo extends LightningElement {
    @wire(MessageContext)
    messagecontext;
    dataReceived;

    connectedCallback(){
        this.subscribeMC();
    }

    subscribeMC() {
        subscribe(this.messagecontext,ACCRESPONSE, (message) => {
            this.handleMessage(message);
        },{scope:APPLICATION_SCOPE});
    }

    handleMessage(message) {
        this.dataReceived = message.accountData.value? message.accountData.value:'No Msg';
        console.log('message:::',this.dataReceived);
    }
}