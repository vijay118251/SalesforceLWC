import { LightningElement,wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ACC_NAME from '@salesforce/schema/Account.Name';
import ACC_PHONE from '@salesforce/schema/Account.Phone';
import ACC_RATING from '@salesforce/schema/Account.Rating';
const FIELDS = [ACC_NAME,ACC_PHONE,ACC_RATING];
import findContactByAccountId from '@salesforce/apex/ContactController.findContactByAccountId';
export default class ChildAccountCmp extends LightningElement {

    recordId='0015g000004jlPbAAI';
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    accList;
    conList;

    handleContact() {
        findContactByAccountId({accountId:this.recordId})
        .then((result) => {
            this.conList = result;
            const sendContact = new CustomEvent('childcontactevent',
            {
                detail:this.conList
            });
            this.dispatchEvent(sendContact);
        })
        .catch((err) => {
            
        });
    }

    handleClick(event) {
        const sendAccount = new CustomEvent('childevent',
        {
            detail:this.accList.data.fields
        });
        this.dispatchEvent(sendAccount);
    }
}