import { LightningElement,api } from 'lwc';
import selectIcon from '@salesforce/apex/MetadataIconElementController.selectIconByPage';

export default class DynamicIconIndicators extends LightningElement {
    @api recordId;
    @api iconTrayName;
    @api pageName;
    iconDetails = [];
    errors;
    isShowContainer = false;

    connectedCallback() {
        this.handleMetadataIconDetails();
    }
    handleMetadataIconDetails() {
        selectIcon({pageName:this.pageName})
        .then((result) => {   
            this.iconDetails = result.details;
            console.log('icon details:::',this.iconDetails);
            this.errors = undefined;
            this.isShowContainer = true;
        })
        .catch((error) => {
            this.iconDetails = undefined;
            this.errors = error;
        });
    }

    handleOnIconClick(event){
        alert('click');
    }

    
}