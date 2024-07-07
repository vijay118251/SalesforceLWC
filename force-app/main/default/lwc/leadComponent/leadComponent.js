import { LightningElement,api } from 'lwc';
import getLeadsRecords from '@salesforce/apex/LeadController.getLeadsRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Company', fieldName: 'Company'},
    { label: 'Title', fieldName: 'Title'},
    { label: 'Email', fieldName: 'Email'},
    { label: 'Status', fieldName: 'Status'}
]
export default class LeadComponent extends LightningElement {
    @api recordId='00Q5g0000026p2vEAA';
    data=[];
    columns = columns;
    name;
    annualRevenue;
    connectedCallback() {
        this.leadCallout();
    }

    leadCallout() {
        getLeadsRecords({name:this.name,annualRevenue:this.annualRevenue})
        .then((result) => {
            this.data = result.leads;
        }).catch((error) => {
            this.ShowToast('Lead data failed',error.body ? error.body.message : error.message, 'error');
            
        });
    }

     ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    handleClick() {
        this.leadCallout();
    }

    changeHandler(event) {
        const eve = event.target.name;
        if(eve == 'input1') {
            this.name=event.target.value;
        }
        if(eve == 'input2') {
            this.annualRevenue=event.target.value;
        }
    }
    

 
}