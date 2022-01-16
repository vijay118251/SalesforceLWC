import { LightningElement } from 'lwc';
import SAMPLEMC1 from '@salesforce/messageChannel/SampleMessageChannel1__c';
import { createMessageContext, releaseMessageContext,publish} from 'lightning/messageService';

export default class PublisherA extends LightningElement {
    context = createMessageContext();
    greeting = 'Vijay M';
    changeHandler(event) {
      this.greeting = event.target.value;
    }

    handleClick(event) {
        const message1 = {
            lms1Data: {value: this.greeting}
        };
        console.log(this.greeting);
        publish(this.context, SAMPLEMC1, message1);

    }
}