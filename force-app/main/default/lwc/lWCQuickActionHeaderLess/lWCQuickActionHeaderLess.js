import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LWCQuickActionHeaderLess extends LightningElement {   
    @api recordId;
 
    @api invoke() {
        this.dispatchEvent(
            new ShowToastEvent( {
                title: 'Success',
                message: 'LWC HeaderLess Quick Action',
                variant: 'success'
            } )
        )
    }  

}