import { LightningElement,wire,api } from 'lwc';
import DispatcherUtilities from'c/lwcDispatcherUtilities';
import { MessageContext } from 'lightning/messageService';
export default class LwcAccountDetails extends LightningElement {

    @api recordId;
    @wire(MessageContext)
    messageContext;
    subscription = null;
    response ={};
    display = [];

    connectedCallback(){
        DispatcherUtilities.fireDispatcherRequest(
            this,
            'getAccountDetails',
            'AccountFire'
        );
    }

    handleResponse(response) {
        console.log(response);
        this.processResponse(response);
    }

    processResponse(response) {
        if(response.values) {
            this.display = response.values;
            console.log(this.display);
            
        }
    }
}