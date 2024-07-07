import { LightningElement } from 'lwc';
import getAccount from '@salesforce/apex/TestClass.getAccount'
export default class LaunchFlowFromLWC extends LightningElement {

singleAccount;

    connectedCallback() {
        getAccount()
        .then((result) =>{
            this.singleAccount = result;
        })
        .catch((error) => {
            console.log(error)
        });
    }

    get inputVariables(){
        return [
            {
                name: 'AccountObject',
                type: 'SObject',
                value: this.singleAccount
            }
        ]
    }

    // handleStatusCange(event){
    //     console.log('handleStatusCange',event.detail);
    // }

}