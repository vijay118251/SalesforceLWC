import { LightningElement , api } from 'lwc';
import NAME_FILED from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
export default class LightningDataServiceFormsExample extends LightningElement {

    @api recordId
    @api objectApiName

    nameField;
    ratingField;

    fields = [NAME_FILED,RATING_FIELD];

    nameField = NAME_FILED;
    ratingField = RATING_FIELD;
}