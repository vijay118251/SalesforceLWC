import { LightningElement } from 'lwc';
import DispatcherElement from 'c/dispatcherElement';
import getAccountDetails from '@salesforce/apex/dispatcherAccountController.getAccountDetails';
export default class LwcDispatcherVehicleInterest extends DispatcherElement {
    REQUEST_NAME = 'VehicleFire'
    methods = {getAccountDetails: getAccountDetails};

}