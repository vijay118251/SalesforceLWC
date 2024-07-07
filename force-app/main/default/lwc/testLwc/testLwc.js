import { LightningElement, track } from 'lwc';

export default class TestLwc extends LightningElement {
	firstNumber = 0;
	secondNumber = 0;
	result = 0;

	handleChanger(event) {
		var val = event.target.name;
		if(val == "fnumber") {
			this.firstNumber = event.target.value;
		}
		else if(val == "snumber"){
			this.secondNumber = event.target.value;
		}
		this.result = parseInt(this.firstNumber) + parseInt(this.secondNumber);
	}
}