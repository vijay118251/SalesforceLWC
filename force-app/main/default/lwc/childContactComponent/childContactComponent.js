import { LightningElement, api, wire } from 'lwc';
import getAssociatedContacts from '@salesforce/apex/TestClass.getAssociatedContacts'
export default class ChildContactComponent extends LightningElement {

    contacts = [];
    error;

    @api idFromParent;

    @wire(getAssociatedContacts, { accId: '$idFromParent' })
    wiredData({ error, data }) { 
      if (data) {
        this.contacts = data;
      } else if (error) {
        this.error = error;
      }
    }

    handleClick(){
        console.log('recordId : ',this.recordId);  
        this.dispatchEvent(new CustomEvent('sendcontactsevent',{
            detail : this.contacts
        }));
    }


}