import { LightningElement } from 'lwc';
import fetchOpportunityDetails from '@salesforce/apex/OpportunityManager.fetchOpportunityDetails';
import closeOpportunity from '@salesforce/apex/OpportunityManager.closeOpportunity';

export default class OpportunityManager extends LightningElement {
    searchOpportunityName;
    opportunities;
    errorDetails;
    opportunityCloseMessage;

    opportunityNameChange(event){
        this.searchOpportunityName = event.target.value;
        fetchOpportunityDetails({oppName:this.searchOpportunityName
        })
        .then(result=>{
            this.opportunities = result;
        })
        .catch(error=>{
            this.errorDetails = error;
        });
    }
    passOpportunityToClose(event){
        this.opportunityId = event.target.name;
        closeOpportunity({opportunityId:this.opportunityId})
        .then(result=>{
            this.opportunityCloseMessage = result;
        })
        .catch(error=>{
           this.errorDetails = error; 
        });
    }
}