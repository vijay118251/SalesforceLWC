import { LightningElement,track } from 'lwc';
export default class ValidationCmp extends LightningElement {
testTheData() {
        let searchCmp = this.template.querySelector(".nameCmp");
        let dateCmp = this.template.querySelector(".dateCmp");
        let searchvalue = searchCmp.value;
        let dtValue = dateCmp.value;
       
        if (!searchvalue) {
            searchCmp.setCustomValidity("Name value is required");
        } else {
            searchCmp.setCustomValidity("");
        }
        searchCmp.reportValidity();

        if (!dtValue) {
            dateCmp.setCustomValidity("Date value is required");
        } else {
            dateCmp.setCustomValidity("");
        }
        dateCmp.reportValidity();
    }
}