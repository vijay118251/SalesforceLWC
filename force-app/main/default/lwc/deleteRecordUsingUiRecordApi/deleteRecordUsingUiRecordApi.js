import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import {deleteRecord} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class DeleteRecordUsingUiRecordApi extends NavigationMixin(LightningElement) {
    recordId = '0015i00000PZD6VAAX';

    handleClick(){
        deleteRecord(this.recordId).then(()=>{
            this.dispatchEvent(new ShowToastEvent({
                title : 'Success',
                message : 'Account deleted successfully',
                variant : 'success'
            }));

            //navigate to record list page
            this[NavigationMixin.Navigate]({
                type : 'standard__objectPage',
                attributes : {
                    objectApiName : 'Account',
                    actionName : 'list'
                },
                state : {
                    filterName: 'Recent'
                }
            });
        })
        .catch(error => {
           this.dispatchEvent(new ShowToastEvent({
                title : 'Error',
                message : error.body.message,
                variant : 'error'
            })); 
        })
    }
}