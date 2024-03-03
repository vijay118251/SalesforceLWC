import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SingleRegistrationForm extends LightningElement {
    activeTabValue = 'one';
    name ='test';
    age;
    showTab2;
    selectedOccupation;
    showSubmit = false;
    occupationOptions = [
        { label: 'Self Employed', value: 'selfEmployed' },
        { label: 'Professional', value: 'professional' },
        { label: 'Government Servant', value: 'governmentServant' },
    ];

    handleChange(event) {
        let input = event.target.value;
        this.age = input.length >= 1 ? input : ''
        this.showTab2 =this.age ? true:false;
    }
    handleNameChange(event) {
        this.name = event.target.value;
    }

    nameHandler(name) {
        if(name) {
            this.showTab2 = false;
            this.activeTabValue ='one';
            const inputFields =  this.template.querySelectorAll('lightning-input');
                inputFields.forEach(fields => {
                    if(fields.name=='txt' && fields.value!=='test') {
                        fields.setCustomValidity('Name should be test');
                        fields.reportValidity();
                    }
                });
            //this.template.querySelector('[data-input="text"]').setCustomValidity('Name should be test');
            //this.template.querySelector('[data-input="text"]').reportValidity();
        }
    }

    errorHandler(msg) {
        if(msg.includes('mismatch')) {
            this.showTab2 = false;
            this.activeTabValue ='one';
            this.template.querySelector('[data-num="age"]').setCustomValidity(msg);
            this.template.querySelector('[data-num="age"]').reportValidity();
        }
    }

    resetValidationError() {
        console.log('resetValidationError');
        this.ShowToast('Submitted','Form Submitted successfully','success');
        const inputFields =  this.template.querySelectorAll('lightning-input');
        console.log(JSON.stringify(inputFields));
        inputFields.forEach(fields => {
            fields.setCustomValidity('');
            fields.reportValidity();
        });
    }

    ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    handleOccupationChange(event) {
        this.selectedOccupation = event.detail.value;
        this.showSubmit = this.selectedOccupation ? true:false;
    }


    handleSubmit() {
            this.age < 13 && this.selectedOccupation !== 'selfEmployed' ? 
            this.errorHandler('Age mismatch should be greater than 13') : 
            this.name!=='test'?this.nameHandler(this.name):this.resetValidationError(); 
    }
}