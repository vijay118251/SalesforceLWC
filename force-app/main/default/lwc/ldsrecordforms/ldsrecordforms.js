import { api, LightningElement} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';


export default class Ldsrecordforms extends LightningElement {
    @api objectApiName;
    @api recordId;

    fields = [NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];

    
}