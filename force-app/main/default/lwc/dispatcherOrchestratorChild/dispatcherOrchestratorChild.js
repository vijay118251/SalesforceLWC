import { api,LightningElement } from 'lwc';
import DispatcherOrchestrator from 'c/dispatcherOrchestrator';
import LwcDispatcherAccount from 'c/lwcDispatcherAccount';
import LwcDispatcherVehicleInterest from 'c/lwcDispatcherVehicleInterest';
export default class DispatcherOrchestratorChild extends DispatcherOrchestrator {
    @api pageName;
    elementMap = {};
    constructor() {
        console.log('constructor call');
        //to call constructor of its parent class
        super();
        // instance of dispatcher elements formed with context id
        this.elementMap.AccountFire = new LwcDispatcherAccount();
        this.elementMap.VehicleFire =  new LwcDispatcherVehicleInterest();
        console.log('elementMap'+JSON.stringify(this.elementMap));
    }

    connectedCallback() {
    // subscribe to dispatcher request and toast lms message channel
     //refers to global object
     console.log('DispatcherOrchestratorChild connected callback');
        this.subscribeMC();
    }

    //disconnectedCallback
    disconnectedCallback() {
        //unsubscribe to dispatcher request
        this.unsubscribeMC();
    }

}