import { LightningElement,api } from 'lwc';

export default class SubRegistrationForm extends LightningElement {
    @api age;
    selectedOccupation;
    occupationOptions = [
        { label: 'Self Employed', value: 'selfEmployed' },
        { label: 'Professional', value: 'professional' },
        { label: 'Government Servant', value: 'governmentServant' },
    ];


    handleOccupationChange(event) {
        this.selectedOccupation = event.detail.value;
    }


    handleSubmit() {
        if (this.age < 13 && this.selectedOccupation !== 'selfEmployed') {
            // Throw an error or handle age mismatch as needed
            console.log('Age mismatch error');
            let throwEvent = new CustomEvent('error',{
                detail: {
                    errMsg:'Age mismatch error',
                    title:'Age should be greater than 13'
                }
            });
            this.dispatchEvent(throwEvent);
        } else {
            // Perform the registration logic here
            let throwEvent = new CustomEvent('error',{
                detail: {
                    title:'Success'
                }
            });
            this.dispatchEvent(throwEvent);
        }
    }
}