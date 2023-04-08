import { LightningElement,api,track,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
export default class LwcPoints extends LightningElement {

    @api recordId;
    @api pagename;
    planType='Wellness';
    error;
    enablePointsDetails = true;
    
    // get record ID from current page reference
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(JSON.stringify(currentPageReference));
        this.recordId  = currentPageReference.attributes.recordId;
    }

}