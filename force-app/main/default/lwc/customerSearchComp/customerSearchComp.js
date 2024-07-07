import { LightningElement } from 'lwc';
import { openTab } from 'lightning/platformWorkspaceApi';
export default class CustomerSearchComp extends LightningElement {
    value = '';

    get options() {
        return [
            { label: 'Inbound', value: 'inbound' },
            { label: 'Outbound', value: 'outbound' },
            { label: 'Offline', value: 'offline' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    handleClick(event) {
        this.handleOpenTab();
    }

    handleOpenTab() {
        openTab({
            url: '/lightning/n/CustomerPage', // The URL of the custom tab to open
            focus: true
        });
    }
    
}