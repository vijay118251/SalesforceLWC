import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class GetPicklistValues extends LightningElement {

    value;
    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    account_info;

    @wire(getPicklistValues, {
        recordTypeId : '$account_info.data.defaultRecordTypeId',
        fieldApiName : INDUSTRY_FIELD
    })
    industryValues;

    handleChange(event){
        this.value = event.target.value;
    }
}