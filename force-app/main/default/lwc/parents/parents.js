import { LightningElement } from 'lwc';

export default class Parents extends LightningElement {
    greeting;
 
    handleCustomEvent(event) {
        this.greeting = event.detail;
 
    }
}