import { LightningElement } from 'lwc';
import { Redux } from 'c/lwcRedux';
import FORM_FACTOR from '@salesforce/client/formFactor';
import {getCustomerDetails,fireCustomer} from 'c/lwcActions';
import * as LwcUtils from 'c/cmpUtils';
export default class ReduxComp extends Redux(LightningElement) {

    loaded=false;
    showChild2=false;

    mapStateToProps(state){
        LwcUtils.log('mapStateToProps',JSON.stringify(state));
        return {
            showCustomer : state.showCustomer,
            customer : state.customer
        };
    }

    mapDispatchToProps(){
        return {getCustomerDetails,fireCustomer};
    }

    connectedCallback() {
        if(FORM_FACTOR==='Large') {
            this.loaded=true;
        }
    }

    handleClick(event) {
        let showCustomer = {
            active : true
        };
        this.props.fireCustomer(showCustomer);
    }

    // handleMyEvent(event) {
    //     this.showChild2 = event.detail.message;
    // }

}