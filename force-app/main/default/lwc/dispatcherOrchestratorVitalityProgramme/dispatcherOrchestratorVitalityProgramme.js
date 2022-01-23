import { LightningElement } from 'lwc';
import DispatcherOrchestrator from 'c/dispatcherOrchestrator';
import LwcDispatcherAccount from 'c/lwcDispatcherAccount';

export default class DispatcherOrchestratorVitalityProgramme extends DispatcherOrchestrator {
    elementMap = {};
    constructor() {
        super();
        this.elementMap.AccountFire = new  LwcDispatcherAccount();
    }
    connectedCallback() {
        this.subscriberMC();
    }
}