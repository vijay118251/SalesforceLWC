import { LightningElement, wire,track } from 'lwc';
import searchMethod from '@salesforce/apex/SearchController.searchMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
 // Define the row actions
const actions = [
    { label: 'View', name: 'view' },
    { label: 'Edit', name: 'edit' },
    { label: 'Delete', name: 'delete' }
    // Add more actions as needed
];
const columns = [
    { label: 'Name', fieldName: 'Name', type:'text'},
    { label: 'Phone', fieldName: 'Phone', type:'currency'},
    { label: 'Id', fieldName: 'Id', type:'text'},
    { type: 'action', typeAttributes: { rowActions: actions, menuAlignment: 'left' } }
];
export default class DynamicSearchComponent extends NavigationMixin(LightningElement) {
    searchTerm='';
    selectedAccount;
    @track accountList = [];
    displayResults = false;
    objectApiName='Account';
    @track fields = ['Id','Name','Phone'];
    error;
    columns = columns


    handleChange(event) {
        let searchText = event.target.value;
        this.searchTerm = searchText.length > 4 ? searchText : '';
    }

    
    @wire(searchMethod,{ObjectApiName:'$objectApiName',fields:'$fields',searchName:'$searchTerm'})
        wiredRecords({data,error}) {
            if (data) {
                this.accountList = data;
            } else if (error) {
                // Handle error appropriately
                this.ShowToast('data failed',error.body ? error.body.message : error.message, 'error');
            }    
    }

    handleTileClick(event) {
        //const accountId = event.currentTarget.dataset.key;
        this.selectedAccount = event.target.dataset.id;
        this.displayResults = true;
    }

    ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    handleRowAction(event) {
        console.log(JSON.parse(JSON.stringify(event)));
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        // Perform action based on the action name
        switch (actionName) {
            case 'view':
                // Handle view details action
                this.handleViewDetails(row);
                break;
            case 'edit':
                // Handle delete action
                this.handleEditDetails(row);
                break;
            /*case 'delete':
                const rows = this.data;
                const rowIndex = rows.indexOf(row);
                rows.splice(rowIndex, 1);
                this.data = rows;
                break;*/
            // Add more cases for other actions
            default:
                break;
        }
    }

    handleViewDetails(row) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }

    handleEditDetails(row) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: 'Account',
                actionName: 'edit'
            }
        });
    }

      
}