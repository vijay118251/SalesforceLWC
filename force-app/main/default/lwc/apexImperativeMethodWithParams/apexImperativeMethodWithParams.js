import { LightningElement } from 'lwc';
import fetchAccountDetails from '@salesforce/apex/AccountManager.fetchAccountDetails';

export default class ApexImperativeMethodWithParams extends LightningElement {
    searchKey = '';
    accounts;
    error;
    

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        fetchAccountDetails({ accName: this.searchKey })
            .then((result) => {
                console.log(result);
                this.accounts = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
            });
    }
    
}