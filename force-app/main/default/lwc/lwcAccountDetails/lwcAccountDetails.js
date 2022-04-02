import { LightningElement,wire,api } from 'lwc';
import DispatcherUtilities from 'c/lwcDispatcherUtilities';
import { MessageContext } from 'lightning/messageService';
export default class LwcAccountDetails extends LightningElement {

    @api recordId;
    /* get messageContext for dispatcher */
    @wire(MessageContext)
    messageContext;
    subscription = null;
    response ={};
    display = [];

    /* lwc connected callback lifecycle hook method */
    connectedCallback(){
        DispatcherUtilities.fireDispatcherRequest(
            this,
            'getAccountDetails',
            'AccountFire'
        );
    }

    /* handle response from LMS*/
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

     /*  lwc disconnected callback lifecycle hook method 
     disconnectedCallback() {
        /* unsubscribeResponseLMS  
        DispatcherUtilities.unsubscribeResponseLMS(this);
    } */
}