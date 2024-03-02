import { LightningElement } from 'lwc';
import DispatcherElement from 'c/dispatcherElement';
import getAccountDetails from '@salesforce/apex/dispatcherAccountController.getAccountDetails';

export default class LwcDispatcherAccount extends DispatcherElement {
    REQUEST_NAME = 'AccountFire';
    methods = {'getAccountDetails': getAccountDetails};
}