import { LightningElement,wire,api, track } from 'lwc';
import { MessageContext,publish } from 'lightning/messageService';
import ACCINFO from '@salesforce/messageChannel/accountInfoChannel__c';
import fetchAccount from '@salesforce/apex/AccountElementController.selectFromId';

export default class PublishAccountInfo extends LightningElement {

    @wire(MessageContext)
    messagecontext;
    @api recordId;
    results;
    accounts={};
    cases;
    errors;

    connectedCallback() {
        this.handleAccountDetails();
    }

    handleAccountDetails() {
        fetchAccount({accId:'0015g000004jlPWAAY'})
        .then((result) => {
            this.results = result;
            console.log('result==>',this.results);    
            this.accounts = result.account;
            console.log('accounts--->',this.accounts);
            this.cases = result.accCase;
            this.errors = undefined;
        })
        .catch((error) => {
            this.accounts = undefined;
            this.errors = error;
        });
        
    }

    handlePublish() {
        const payload = {
            accountData : {value:this.accounts}
        };
        console.log('LMS-->',payload);
        publish(this.messagecontext,ACCINFO,payload);
    }
}