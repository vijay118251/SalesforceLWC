import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class WireAccountData extends LightningElement {

    err;
    accounts;
    @wire(getAccounts)
    wiredAccounts({data,error}) {
        if(data) {
            if(data.length>0) {
                this.accounts = data[0];
            }
        } else if(error){
            this.err = error;
        }
    }
}