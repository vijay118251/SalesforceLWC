import { LightningElement } from 'lwc';
export default class LightningRecordPicker extends LightningElement {
handleChange( event ) {
console.log(event.detail.recordId);
}
}