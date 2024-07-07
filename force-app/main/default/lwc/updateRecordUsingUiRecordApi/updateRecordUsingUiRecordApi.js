import { LightningElement, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
export default class UpdateRecordUsingUiRecordApi extends LightningElement {
    
    @api recordId;

    name;
    rating;

    handleValidation(){
        console.log('Entered handle validation');
        const res =  [...this.template.querySelectorAll('lightning-input')].reduce(
            (validSoFar, inputField) => {
                inputField.reportValidity();
                console.log(`${validSoFar} ${inputField.checkValidity()}`);
                return validSoFar && inputField.checkValidity();
            },
            true
        );
        console.log(res);
    }

    handleChange(event){
        if(event.target.name === 'name'){
            this.name = event.target.value;
        }
        else if(event.target.name === 'rating'){
            this.rating = event.target.value;
        }
    }

    handleClick(){
        let isValid = true;
            [...this.template.querySelectorAll('lightning-input')]
                .forEach(fields => {
                    if(fields.value == '') {
                        fields.setCustomValidity('Value is required');
                        isValid = false;
                    } else {
                        fields.setCustomValidity('');
                    }
                    fields.reportValidity();
                });

        if(isValid){
            const fields = {};
            fields[ID_FIELD.fieldApiName] = this.recordId;
            fields[NAME_FIELD.fieldApiName] = this.name;
            fields[RATING_FIELD.fieldApiName] = this.rating;

            const recordInput = {fields : fields};

            updateRecord(recordInput).then((account) => {
                this.dispatchEvent(new ShowToastEvent({
                    title : 'Success',
                    message : 'Account updated successfully',
                    variant : 'success'
                }));
            })
            .catch((error) => {
                this.dispatchEvent(new ShowToastEvent({
                    title : 'Error',
                    message : error.body.message,
                    variant : 'error'
                }));
            })    
        }
    }
}