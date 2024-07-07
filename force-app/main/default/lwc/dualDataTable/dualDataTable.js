import { LightningElement, wire,track } from 'lwc';
import getAccountData from '@salesforce/apex/AccountControllerDB.getAccountData';
export default class DualDataTable extends LightningElement {
    @track accountData = [];
    @track selectedAccountData = [];
    @track selectedRows = [];
    accountColumns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Type', fieldName: 'Type' }
    ];

    @wire(getAccountData)
    wiredAccountData({ error, data }) {
        if (data) {
            // Add a radioSelect property to each row for radio buttons
            this.accountData = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleRowSelection(event) {
        console.log('OUTPUT : ',JSON.stringify(event.detail));
        const selectedRow = event.detail.selectedRows[0];
        this.selectedRows = [selectedRow];
        console.log('OUTPUT : ',JSON.stringify(this.selectedRows));
        // Filter the selected row from accountData and update selectedAccountData
        this.selectedAccountData = this.accountData.filter(
            (row) => row.Id === selectedRow.Id
        );
    }
}