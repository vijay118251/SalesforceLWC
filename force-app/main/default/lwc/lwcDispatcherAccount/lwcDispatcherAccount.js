import { LightningElement } from 'lwc';
import getAccountDetails from '@salesforce/apex/dispatcherAccountController.getAccountDetails';

export default class LwcDispatcherAccount extends LightningElement {
    REQUEST_NAME = 'AccountFire'
    methods = {getAccountDetails: getAccountDetails};
}