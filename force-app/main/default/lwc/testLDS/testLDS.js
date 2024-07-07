import { LightningElement , api} from 'lwc';
export default class TestLDS extends LightningElement {
    @api recordId;
    @api objectApiName;
}