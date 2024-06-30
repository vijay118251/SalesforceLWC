import { LightningElement,api } from 'lwc';

export default class ConfirmationModal extends LightningElement {
    @api isConfirm=false;

    constructor() {
        super();
        console.log('Child Constructor Called');
    }
    connectedCallback() {
        console.log('Child Connected Callback Called');
    }

    renderedCallback() {
        console.log('Child Rendered Callback Called');
    }

    disconnectedCallback() {
        console.log('Child Disconnected Callback Called');
    }

    errorCallback(error,stack) {
        console.log('Child Error Callback Called',error);
        console.log('Child Error Stack Called',stack);
    }

    handleModal(event) {
        this.isConfirm = false;
        let btnRef = this.template.querySelector('[data-right]').value;
        const fireModalEvent = new CustomEvent('modalevent',
            {
                detail:{
                    isConfirm: this.isConfirm,
                    btnRefVal: btnRef
                }
            });
            this.dispatchEvent(fireModalEvent);
    }

    closeModal() {
        this.isConfirm = false;
        let btnRef = this.template.querySelector('[data-left]').value;
        const fireModalEvent = new CustomEvent('modalevent',
            {
                detail:{
                    isConfirm: this.isConfirm,
                    btnRefVal: btnRef
                }
            });
            this.dispatchEvent(fireModalEvent);
    }
}