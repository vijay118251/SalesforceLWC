import { LightningElement,api } from 'lwc';

export default class LDSCRecordEdit extends LightningElement {
   @api recordId;
    successHandler(event){
            this.recordId = event.detail.id;
        }
}