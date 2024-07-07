import { LightningElement } from 'lwc';
export default class CalloutFlowCmp extends LightningElement {
    clickedButton = false;
    showButton = true;

    // Show User Records
    handleClick(event) {
        if(event.target.name == "User") {
            this.clickedButton = true;
            this.showButton = false;
        }
        if(event.target.name == "Close") {
            this.clickedButton = false;
            this.showButton = true;
        }

    }

}