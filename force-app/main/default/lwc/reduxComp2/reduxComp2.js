import { LightningElement } from 'lwc';
import { Redux } from 'c/lwcRedux';
import * as LwcUtils from 'c/cmpUtils';
export default class ReduxComp2 extends Redux(LightningElement) {
    fullName;
    get firstName() {
        return this.props.customer?.customerData?.firstName;
    }

    get lastName() {
        return this.props.customer?.customerData?.lastName;
    }

    get company() {
        return this.props.customer?.customerData?.company;
    }

    get jobTitle() {
        return this.props.customer?.customerData?.jobTitle;
    }

    mapStateToProps(state){
        LwcUtils.log('mapStateToProps reduxComp2-->',JSON.stringify(state));
        return {customer : state.customer};
    }
}