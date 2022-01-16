import { LightningElement } from 'lwc';

export default class LDSCRecordEdit extends LightningElement {
    recordId;
    successHandler(event){
            this.recordId = event.detail.id;
        }
}