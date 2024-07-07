import { LightningElement , track } from 'lwc';

export default class MyTest extends LightningElement {
	@track msg;
	handleMsg(event)
	{
		this.msg = event.target.value;
	}
}