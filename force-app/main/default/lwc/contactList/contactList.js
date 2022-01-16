import { LightningElement,track,wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import First_Name from '@salesforce/schema/Contact.FirstName';
import Last_Name from '@salesforce/schema/Contact.LastName';
import Email_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'FirstName', fieldName: First_Name.fieldApiName, type: 'text' },
    { label: 'LastName', fieldName: Last_Name.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: Email_FIELD.fieldApiName, type: 'email' }
];

export default class ContactList extends LightningElement {
    columns = COLUMNS;
    @wire(getContacts)
    contacts;

    get errors() {
        return (this.accounts.error) ?
            reduceErrors(this.accounts.error) : [];
    }
}