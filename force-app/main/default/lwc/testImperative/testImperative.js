import { LightningElement, api, track } from 'lwc';
import getAssociatedContacts from '@salesforce/apex/TestClass.getAssociatedContacts'
export default class TestImperative extends LightningElement {

    @api recordId;
    @api object;
    @track contacts = [];
    @track error;

    connectedCallback() {
        getAssociatedContacts({accId : this.recordId})
        .then((result) => {
            this.contacts = result;
        })
        .catch((error) => {
            this.error = error;
        });
    }   
}