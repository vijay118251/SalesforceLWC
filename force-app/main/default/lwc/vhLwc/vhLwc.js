import { LightningElement,api,wire,track } from 'lwc';
import getVehicleInterestRecords from '@salesforce/apex/GetVehicleRecords.getVehicleInterestRecords';
export default class VhLwc extends LightningElement {
    @track columns = [
        {
            label: 'VehicleInterest name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Type',
            fieldName: 'Type__c',
            type: 'text',
            sortable: true
        },
        {
            label: 'Email',
            fieldName: 'Email__c',
            type: 'email',
            sortable: true
        },
        {
            label: 'Customer',
            fieldName: 'Customer__c',
            type: 'text',
            sortable: true
        },
        { 
            label: 'Status', cellAttributes:
            { iconName: { fieldName: 'priorityicon' }}},
    ];

    @track error;
    @track vhList ;
    @wire(getVehicleInterestRecords)
    wiredVehicleInterests({
        error,
        data
    }) {
        if (data) {
            this.vhList = data;
            this.selectedRows = data.length > 0 ? [data[0].Id] : [];
            
            this.vhList = data.map((item) => {
            const iconObj = {...item};
            if(item.Type__c === 'Truck'){
                iconObj.priorityicon = "action:approval";
            }else if(item.Type__c === 'SUV'){
                iconObj.priorityicon = "action:close";
            }else{
                iconObj.priorityicon = "action:delete";
            }
        return iconObj;
    });

        } else if (error) {
            this.error = error;
        }
    }

}