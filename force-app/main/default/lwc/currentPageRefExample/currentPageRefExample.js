import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
export default class CurrentPageRefExample extends LightningElement {
    @api recordId;
    currentPageReference;
    attbs;
    state;
    type;

    @wire(CurrentPageReference)
    getPageReferenceParameters(currentPageReference){
        if(currentPageReference){
            this.currentPageReference = JSON.stringify(currentPageReference);
            console.log(currentPageReference);
            this.recordId = currentPageReference.attributes.recordId;
            this.attbs = JSON.stringify(currentPageReference.attributes);
            this.type = JSON.stringify(currentPageReference.type);
        }
    }
}