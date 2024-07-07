import { LightningElement, wire, api } from 'lwc';
import getAssociatedOpportunities from '@salesforce/apex/TestClass.getAssociatedOpportunities';
// import NAME_FIELD from '@salesforce/schema/Account.Name';
// import Phone from '@salesforce/schema/Account.Phone';
export default class TestDataBinding extends LightningElement {

    name;
    handleChanges(event){
        this.name = event.target.value;
    }

    showText = false;
    greeting;
    handleClick(){
        this.showText = true;
        this.greeting = this.name ? `Hey ${this.name} , you have clicked the button!!` : 'Sorry!! Please enter the name..';
    }

    @api recordId;
    @wire(getAssociatedOpportunities, {accId : '$recordId'})
    opportunities;

    //get name and phone fields
    

}