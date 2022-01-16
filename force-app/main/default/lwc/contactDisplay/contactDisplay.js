import { LightningElement,wire } from 'lwc';
import findContacts from '@salesforce/apex/ContactMaster.findContacts';
export default class ContactDisplay extends LightningElement {
    searchKey = '';

    @wire(findContacts, { searchKey: '$searchKey' })
    contacts;
    

    handleKeyChange(event) {
        const searchValue = event.target.value;
            this.searchKey = searchValue;
    }
    
    
}