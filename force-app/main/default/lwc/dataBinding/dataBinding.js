import { LightningElement,api } from 'lwc';
export default class DataBinding extends LightningElement {

firstName='Deepu';
lastName='Viju';
passChild='';
showDetails=true;
disabled=false;

get footerName() {
    return 'Card'
}

@api
get parentFire() {
    return this.passChild;
}

set parentFire(value) {
    this.passChild = value;
    this.showDetails =false;
}

handleClick(event) {
    var input = this.template.querySelectorAll('lightning-input');
    console.log(input);
    input.forEach(currentItem => {
        //TODO : currentItem
        if(currentItem.name=='fname') {
            this.firstName = currentItem.value;
            if (!this.firstName) {
            currentItem.setCustomValidity("First Name value is required");
            } else {
            currentItem.setCustomValidity("");
            }
            currentItem.reportValidity();
        }
        else if(currentItem.name=='lname') {
            this.lastName = currentItem.value;
            if (!this.lastName) {
            currentItem.setCustomValidity("Last Name value is required");
            } else {
            currentItem.setCustomValidity("");
            }
            currentItem.reportValidity();
        }       
    });
    this.disabled=(!!this.firstName && !!this.lastName)?true:false;
}

enableButton() {
    this.disabled=false;
}

}