import { LightningElement,api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { FlowNavigationBackEvent,FlowNavigationNextEvent} from "lightning/flowSupport";
const columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Type', fieldName: 'Type__c', editable: true},
    { label: 'Color', fieldName: 'Exterior_Color__c', editable: true},
    { label: 'Sun Roof', fieldName: 'Sunroof__c', editable: true},
    { label: 'Model', fieldName: 'Model__c', editable: true},
];
export default class LwcFlowCmp extends LightningElement {
    //recieve value from flow here
    @api vehicleRecords=[];
    columns = columns;
    rowOffset = 0;
    saveDraftValues = [];
    valueToFlow=[];
    @api vehicleDraftRecords=[];
    @api availableActions = [];
    @api clickedButton;


    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        let keyPair = [];
        event.detail.draftValues.forEach(item =>
         keyPair.push({Id: item.Id, Model__c: item.Model__c
         }));
        this.vehicleDraftRecords = keyPair;

        // Updateing the records
            this.ShowToast('Success', 'Records Updated Successfully!', 'success');
            this.saveDraftValues = [];
            this.handleNext();
    }

    handleNext() {
    if (this.availableActions.find((action) => action === "NEXT")) {
      const navigateNextEvent = new FlowNavigationNextEvent();
      this.dispatchEvent(navigateNextEvent);
        }
    }
    
    ShowToast(title, message, variant, mode){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    // Add New Records
    handleClick(event) {
        this.clickedButton = event.target.name;
        this.handleNext();
    }
}