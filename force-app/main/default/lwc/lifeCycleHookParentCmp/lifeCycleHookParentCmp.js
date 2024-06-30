import { LightningElement } from 'lwc';

export default class LifeCycleHookParentCmp extends LightningElement {
    count = 0;
    message='Hello World';
    show=false;

    constructor() {
        super();
        console.log('Parent Constructor Called');
        console.log('count==>',this.count);
        console.log('message==>',this.message);
        console.log(this.template.querySelector('p'));
    }

    connectedCallback() {
        console.log('Parent Connected Callback Called');
        console.log('count==>',this.count);
        console.log('message==>',this.message);
        console.log(this.template.querySelector('lightning-card'));
    }

    renderedCallback() {
        console.log('Parent Rendered Callback Called');
        console.log('count==>',this.count);
        console.log('message==>',this.message);
        console.log(this.template.querySelector('lightning-card'));
    }

    disconnectedCallback() {
        console.log('Parent Disconnected Callback Called');
    }

    errorCallback(error,stack) {
        console.log('Parent Error Callback Called',error);
        console.log('Parent Error Stack Called',stack);
    }

    handleCheckboxChange(event) {
        const isChecked = event.target.checked;
        this.show = isChecked ? true : false
        this.count++;
    }
}