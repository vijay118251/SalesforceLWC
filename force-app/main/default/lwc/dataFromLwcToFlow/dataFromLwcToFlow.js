import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import { LightningElement, api } from 'lwc';
export default class DataFromLwcToFlow extends LightningElement {

    @api firstName

    handleChange(event){
        this.firstName = event.target.value;
        this.dispatchEvent(new FlowAttributeChangeEvent('firstName', this.firstName));
    }
}