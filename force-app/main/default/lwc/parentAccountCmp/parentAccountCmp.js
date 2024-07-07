import { LightningElement } from 'lwc';
export default class ParentAccountCmp extends LightningElement {
    show=false;
    showContact = false;
    accList={};
    conList=[];
    handleEvent(event) {
        this.accList = event.detail;
        this.show = true;
    }
    handleContactEvent(event) {
        this.conList=event.detail;
        this.showContact = true;
    }
}