import { LightningElement, wire ,track} from 'lwc';
import getOpportunityRecords from '@salesforce/apex/opportunitycontroller.getOpportunityRecords';
export default class Displaydatausingtable extends LightningElement {
@track datas;
@track columns = [
    { label: 'Name', fieldName: 'Name', type:'text'},
    { label: 'Amount', fieldName: 'Amount', type:'currency'},
    { label: 'Stage Name', fieldName: 'StageName', type:'text'},
    { label: 'Closed Date', fieldName: 'CloseDate', type:'date'}
];
 
@wire(getOpportunityRecords) opportunity({data,error}) {
    console.log(JSON.stringify(data))
    if(data) {
        
        this.datas=data;
        
    } else if(error) {
        this.datas=undefined;
        
    }




}


}