import { LightningElement, api, wire } from 'lwc';
import getAssociatedContacts from '@salesforce/apex/TestClass.getAssociatedContacts'
import getAssociatedOpportunities from '@salesforce/apex/TestClass.getAssociatedOpportunities'

export default class ShowContactsAndOpportunities extends LightningElement {

    @api selectedValue;
    @api recordIdFromParent;

    contacts = [];
    opportunities = [];
    error;

    /*connectedCallback() {
        this.contact = this.selectedValue == 'contact' ? true : false;
    }*/

    @api
    get contact(){
        console.log('selectedValue-->',this.selectedValue);
        return this.selectedValue == 'contact' ? true : false;
    }

    @api
    get opportunity(){
        console.log('selectedValue-->',this.selectedValue);
        return this.selectedValue == 'opportunity' ? true : false;
    }


    @wire(getAssociatedContacts, {accId: '$recordIdFromParent'})
    wiredContacts({data, error}){
        if(data){
            this.contacts = data;
        }
        else if(error){
            this.error = error;
        }
    }

    @wire(getAssociatedOpportunities, {accId: '$recordIdFromParent'})
    wiredOpportunities({data, error}){
        if(data){
            this.opportunities = data;
        }
        else if(error){
            this.error = error;
        }
    }

    /*handleOpportunities(){
        console.log('selectedValue : ',this.selectedValue);  
        this.dispatchEvent(new CustomEvent('sendopportunityevent',{
            detail : this.opportunities
        }));
    }

    handleContacts(){
        console.log('selectedValue : ',this.selectedValue);  
        this.dispatchEvent(new CustomEvent('sendcontactevent',{
            detail : this.contacts
        }));
    }*/
    
}