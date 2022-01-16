import { LightningElement } from 'lwc';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel3__c';
import { createMessageContext, releaseMessageContext,publish} from 'lightning/messageService';
import { NavigationMixin } from 'lightning/navigation';


export default class LmsNavComA extends NavigationMixin(LightningElement) {
    context = createMessageContext();
    greeting = 'World';
    changeHandler(event) {
      this.greeting = event.target.value;
    }

    handleClick(event) {
        console.log('publish data');
        const message = {
            lms3Data: {value: this.greeting}
        };
        publish(this.context, SAMPLEMC, message);
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Communications'
            },
        });

    }
}