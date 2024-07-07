// registrationForm.js
import { LightningElement, track } from 'lwc';

export default class RegistrationComponent extends LightningElement {
    @track age;
    @track selectedOccupation;
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
            console.error('Age mismatch error');
        } else {
            // Perform the registration logic here
            console.log('Registration successful');
        }
    }
}