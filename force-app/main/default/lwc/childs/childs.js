import { LightningElement } from 'lwc';

export default class Childs extends LightningElement {
    handleChange(event) {
        const name = event.target.value;
        const selectEvent = new CustomEvent('myfirstcustomevent', {
            detail: name
        });
       this.dispatchEvent(selectEvent);
    }
}