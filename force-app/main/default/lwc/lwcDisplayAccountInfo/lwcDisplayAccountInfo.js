import { LightningElement,api,wire } from 'lwc';
import fetchAccount from '@salesforce/apex/AccountElementController.selectFromId';
import { CurrentPageReference } from 'lightning/navigation';

export default class LwcDisplayAccountInfo extends LightningElement {
    @api recordId;
    accounts;
    cases;
    errors;
    accountDetails={};

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
          this.recordId = currentPageReference.attributes.recordId || null;
          this.accountDetails.recordId = currentPageReference.attributes.recordId;
          this.accountDetails.states = currentPageReference.state;
          this.accountDetails.type = currentPageReference.type;
          console.log('Current page details',this.accountDetails);
       }
    }

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