import { LightningElement } from 'lwc';

export default class MyValidationComponent extends LightningElement {
    handleSubmit() {
        if (this.checkIfInputsValid()) {
            // All inputs are valid, proceed with form submission or other actions
            console.log('All inputs are valid. Proceeding with submission...');
        } else {
            // Inputs are invalid, display an error message or handle accordingly
            console.log('Some inputs are invalid. Please correct them.');
        }
    }

    checkIfInputsValid() {
        return [...this.template.querySelectorAll('lightning-input')].reduce(
            (validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            },
            true
        );
    }
}