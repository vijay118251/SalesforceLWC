import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import insertAccounts from '@salesforce/apex/CreateAccounts.insertAccounts';
import firePlatformEvents from '@salesforce/apex/CreateAccounts.firePlatformEvents';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LwcPlatformEventCmp extends LightningElement {
accountid;
error;
accountRecords=[];
accRecord={};
successCount;
failureCount;
forceRerender = false;
inputValue;
 handleChange(event){
    this.accRecord[event.target.name] = event.target.value;
 }

 handleInputChange(event) {
    this.inputValue = event.target.value;
 }
 handleClick() {
    firePlatformEvents({inputValue:this.inputValue})
    .then(result=>{
            console.log('completed',result);
            this.forceRerender = !this.forceRerender;
            // Subscribe to Platform Event
            subscribe('/event/RecordCount__e', -1, (response)=>{
                console.log(JSON.parse(JSON.stringify(response)));
                this.successCount = response.data.payload.Success_Count__c;
                this.failureCount = response.data.payload.Failure_Count__c;
            });
        })
        .catch(error=>{
            this.error = error.message;
        });
 }
//  handleSaveAccount(){
//     console.log(JSON.parse(JSON.stringify(this.accRecord)))
//     insertAccounts({accountRecObj:this.accRecord})
//     .then(result=>{
//         console.log('completed',result);
//         this.forceRerender = !this.forceRerender;
//         // Subscribe to Platform Event
//         subscribe('/event/RecordCount__e', -1, this.handleEvent);
//     })
//     .catch(error=>{
//         this.error = error.message;
//     });
//  }

renderedCallback(){
    console.log('Parent renderedCallback Called');
}

}