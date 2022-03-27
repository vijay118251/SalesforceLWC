import { LightningElement,api } from 'lwc';
import fetchAccount from '@salesforce/apex/AccountElementController.selectFromId';

export default class LwcDisplayAccountInfo extends LightningElement {
    @api recordId;
    accounts;
    cases;
    errors;

    connectedCallback() {
        this.handleAccountDetails();
    }

    handleAccountDetails() {
        fetchAccount({accId:this.recordId})
        .then((result) => {
            console.log('result==>',result);
            console.log('case-->',result.accCase);
            console.log('request-->',result.command);    
            this.accounts = result.account;
            this.cases = result.accCase;
            this.errors = undefined;
        })
        .catch((error) => {
            this.accounts = undefined;
            this.errors = error;
        });
    }
}