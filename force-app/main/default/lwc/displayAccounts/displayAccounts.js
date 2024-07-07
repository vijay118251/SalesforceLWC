import getAccounts from '@salesforce/apex/TestClass.getAccounts';
import { LightningElement,track, wire } from 'lwc';

export default class DisplayAccounts extends LightningElement {
	@track data;
	@wire(getAccounts) accountRecords({error,data}){
		if(data){
			this.data = data;
		}
		else if(error){
			this.data = undefined;
		}
	}
}