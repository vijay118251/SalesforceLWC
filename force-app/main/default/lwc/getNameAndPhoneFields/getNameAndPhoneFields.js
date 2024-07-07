import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Name from '@salesforce/schema/Account.Name';
import Phone from '@salesforce/schema/Account.Phone';

const Fields = [
        'Account.Name',
        'Account.Phone'
    ]
export default class GetNameAndPhoneFields extends LightningElement {

    

    @api recordId;
    @wire(getRecord, {recordId : '$recordId', fields : Fields})
    record;

    get name(){
        //return this.record.data ? getFieldValue(this.record.data, Name ) : '';
        return this.record.data.fields.Name.value;
        
    }

    get phone(){
        //return this.record.data ? getFieldValue(this.record.data, Phone) : '';
        return this.record.data.fields.Phone.value;
    }

}