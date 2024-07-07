import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class UtilityToast extends LightningElement {

    static publishToast(variant,title,message) {
         // form toast payload
            const errorToast = new ShowToastEvent({
                variant: variant,
                title: title,
                message:message
            });
            // dispatch toast event
            dispatchEvent(errorToast);
    }

}