import { LightningElement,wire,api,track } from 'lwc';
import DispatcherUtilities from 'c/lwcDispatcherUtilities';
import { MessageContext } from 'lightning/messageService';
export default class LwcAccountDetails extends LightningElement {

    @api recordId;
    /* get messageContext for dispatcher */
    @wire(MessageContext)
    messageContext;
    subscription = null;
    response ={};
    @track display={};

    /* lwc connected callback lifecycle hook method */
    connectedCallback(){
        console.log('connectedCallback');
        // subscribe to dispatcher LMS response channel
        DispatcherUtilities.subscribeResponseLMS(this);
        DispatcherUtilities.fireDispatcherRequest(
            this,
            'getAccountDetails',
            'AccountFire'
        );
    }

    /* handle response from LMS*/
    handleResponse(response) {
        console.log(response);
        // process responses only from requested RSection
        if (
            DispatcherUtilities.responseMatches(
                this,
                'getAccountDetails',
                'AccountFire',
                response
            )
        ) {
        this.processResponse(response);
    }
    }

    processResponse(response) {
        if(response) {
            this.display = response.account;
            console.log('display==>'+JSON.stringify(this.display));
            
        }
    }

   /*  lwc disconnected callback lifecycle hook method */
    disconnectedCallback() {
        DispatcherUtilities.unsubscribeResponseLMS(this);
    }
}