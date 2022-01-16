import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactModal extends LightningElement {
    showModal=false; 
    handleClick(){
        this.showModal=true;
    }

    closeModal(){
        this.showModal=false;
    }

    handleSuccess() {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Completed!',
            message: 'Contact Created Successfully.',
            variant:'success'
        }), );
        this.closeModal();
    }
}