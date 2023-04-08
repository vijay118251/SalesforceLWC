import { LightningElement,api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { convertDate } from 'c/dateFormatting';
import selectFromAccId from '@salesforce/apex/PointsElementController.selectFromAccId';
export default class Banner extends LightningElement {

    @api title='';
    @api pageName='';
    planType='Wellness';
    displayTitle;
    pointDetails={};
    recId='a095g000004c8tYAAQ';

    /* get context*/
    get context() {
        return `${this.pageName}/${this.planType}`;
    }

    /* lwc connected callback lifecycle hook method */
    connectedCallback() {
        console.log('connectedCallback banner');
        if(this.pageName) {
            this.firePointsRequest();
        }
    }

    /* fire request */
    firePointsRequest() {
        selectFromAccId({accId:this.recId})
            .then((response) => {
                this.publishResponse(response)   
            }).catch((err) => {
                this.error = err;
            });
    }

    /* handle response */
    publishResponse(response) {
        if(response.command.method == 'selectFromAccId') {
            this.processPointsResponse(response);
        }
    }

    /* process response */
    processPointsResponse(response) {
        this.pointDetails = response.details;
        console.log('response-->',JSON.stringify(this.pointDetails));
        this.handleResponse();
    }

    handleResponse() {
        if(this.pointDetails && this.pointDetails.length>0) {
            this.pointDetails.forEach(plan => {
                if(plan.planType === this.planType) {
                    let date = new Date(plan.renewalDate);
                    console.log('date-->',date);
                    let renwDate = convertDate(new Date(date.getFullYear(), date.getMonth(), date.getDate() - 1));
                    console.log('renwDate-->',renwDate);
                    this.displayTitle = `Plan Year:
                    ${plan.previousRenewalDate} > ${renwDate}`;
                    console.log('title-->',this.displayTitle);
                }
            });
        } else {
            this.displayTitle = 'Plan Year:: YYYY-MM-DD > YYYY-MM-DD';
        }
    }
          
}