import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class RegistrationForm extends LightningElement {
    age;
    showTab2;

    handleChange(event) {
        let input = event.target.value;
        this.age = input.length >= 1 ? input : ''
        this.showTab2 =this.age ? true:false;
    }

    errorHandler(event) {
        if(event.detail.errMsg) {
            this.template.querySelector('lightning-input[data-num="age"]').setCustomValidity(event.detail.title);
            this.template.querySelector('lightning-input[data-num="age"]').reportValidity();
        } else if(event.detail.title=='Success'){
            this.template.querySelector('lightning-input[data-num="age"]').setCustomValidity('');
            this.template.querySelector('lightning-input[data-num="age"]').reportValidity();
            this.ShowToast('Submitted','Form Submitted successfully','success');
        }
    }

    ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }
}