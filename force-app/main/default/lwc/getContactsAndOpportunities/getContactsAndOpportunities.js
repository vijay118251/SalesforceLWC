import { LightningElement, api } from 'lwc';
export default class GetContactsAndOpportunities extends LightningElement {

    @api value = '';
    @api recordId;

    get options() {
        return [
            { label: 'Contacts', value: 'contact' },
            { label: 'Opportunities', value: 'opportunity' },
        ];
    }

    get testValue(){
        if(this.value == 'contact'){
            return 'contact clicked!';
        }
        else if(this.value == 'opportunity'){
            return 'opportunity clicked!';
        }
    }

    handleRadioChange(event){
        this.value = event.detail.value;
    }


}