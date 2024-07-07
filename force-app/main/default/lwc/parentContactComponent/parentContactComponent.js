import { LightningElement, api } from 'lwc';
export default class ParentContactComponent extends LightningElement {

    @api recordId;

    contacts;

    handleContacts(event){
        this.contacts = event.detail;
    }

}