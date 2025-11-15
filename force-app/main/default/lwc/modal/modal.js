import { LightningElement,api } from 'lwc';

export default class Modal extends LightningElement {
    @api modalClass = "slds-modal slds-fade-in-open slds-modal_large";
    countdown = 3;
    countdownInterval;

    connectedCallback() {
        //console.log('modalClass in modal>>',this.modalClass);
        this.autoCloseModal();
    }

    autoCloseModal() {
        this.countdownInterval = setInterval(() => {
            this.countdown--;
            if (this.countdown <= 0) {
                clearInterval(this.countdownInterval);
                this.dispatchEvent(new CustomEvent('closemodal', {
                    detail: { autoClose: true }
                }));
            }
        }, 1000);
    }
}