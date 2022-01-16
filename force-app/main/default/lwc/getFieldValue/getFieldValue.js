import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
const fields = [NAME_FIELD,REVENUE_FIELD, RATING_FIELD,PHONE_FIELD, INDUSTRY_FIELD];

export default class GetFieldValue extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    account;

    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }

    get revenue() {
        return getFieldValue(this.account.data, REVENUE_FIELD);
    }

    get phone() {
        return getFieldValue(this.account.data, PHONE_FIELD);
    }
    get rating() {
        return getFieldValue(this.account.data, RATING_FIELD);
    }

    get industry() {
        return getFieldValue(this.account.data, INDUSTRY_FIELD);
    }
}