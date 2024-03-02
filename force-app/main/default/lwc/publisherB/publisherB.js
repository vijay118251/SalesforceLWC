import { LightningElement } from 'lwc';
import SAMPLEMC2 from '@salesforce/messageChannel/SampleMessageChannel2__c';
import { createMessageContext, releaseMessageContext,publish} from 'lightning/messageService';
export default class PublisherB extends LightningElement {
    context = createMessageContext();
    greetings = 'World';
    changeHandler(event) {
      this.greetings = event.target.value;
    }

    handleClick(event) {
        const message2 = {
            lms2Data: this.greetings
        };
        publish(this.context, SAMPLEMC2, message2);

    }
}