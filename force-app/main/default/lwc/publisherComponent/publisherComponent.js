import { LightningElement, wire } from 'lwc';
import firstChannel from '@salesforce/messageChannel/firstChannel__c';
import {publish, MessageContext} from 'lightning/messageService'
export default class PublisherComponent extends LightningElement {

    message;
    @wire(MessageContext)
    messageContext;

    handleChange(event){
        this.message = event.target.value;
        console.log("message-->",this.message);
    }

    handleClick(){
        let message = {Text : this.message};
        console.log("message-->",message);
        publish(this.messageContext, firstChannel, message);
    }

}