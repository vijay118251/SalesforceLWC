import { LightningElement } from 'lwc';
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import { NavigationMixin } from 'lightning/navigation';
export default class LaunchFlowFromLwc extends NavigationMixin(LightningElement) {
    flowApiName = 'LAUNCH_FLOW_FROM_LWC';
    // Setting flow input variables
	accountId = '0015g00001clArSAAU';
	flowInputVariables = [
		{
			name: "accountId",
			type: "String",
			value: this.accountId
		}
	];

    // do something when flow status changed
	handleFlowStatusChange(event) {
		console.log("flow status", event.detail.status);
		if (event.detail.status === "FINISHED") {
			this.dispatchEvent(
				new ShowToastEvent({
					title: "Success",
					message: "Flow Finished Successfully",
					variant: "success",
				})
			);
            //Get the flow output variable and store it.
            const outputVariables = event.detail.outputVariables;
            for(let i= 0; i < outputVariables.length; i++) {
            const outputVar = outputVariables[i];
            //contactId is a variable created in flow.
            if(outputVar.name === 'contactId') {
                console.log(outputVar.value);
                if(outputVar.value != null){
                //Pass the contactId variable value to navigateToRecord.
                this.navigateToRecord(outputVar.value);
            }
                }
            }
        }
	}

    //Navigate to contact detail page.
    navigateToRecord(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }
}