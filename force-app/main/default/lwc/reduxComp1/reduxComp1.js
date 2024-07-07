import { LightningElement,wire } from 'lwc';
import { Redux } from 'c/lwcRedux';
import {getCustomerDetails,fireCustomer} from 'c/lwcActions';
import FORM_FACTOR from '@salesforce/client/formFactor';
import * as LwcUtils from 'c/cmpUtils';
export default class ReduxComp1 extends Redux(LightningElement) {
    loaded=false;

    mapStateToProps(state){
        LwcUtils.log('mapStateToProps reduxComp1',JSON.stringify(state));
        return {
            showCustomer : state.showCustomer
        };
    }

    mapDispatchToProps(){
        return {getCustomerDetails,fireCustomer};
    }

    connectedCallback() {
        super.connectedCallback();
        if(FORM_FACTOR==='Large') {
            this.loaded = true;
            let showCustomer = {
                active : true
            };
            this.props.fireCustomer(showCustomer);

            let payload = {
            "customerData" : {
                firstName:'Vijay',
                lastName:'M',
                company:'Infosys',
                jobTitle:'Salesforce Developer'
                }
            };
            this.props.getCustomerDetails(payload);

        }
    }  
}