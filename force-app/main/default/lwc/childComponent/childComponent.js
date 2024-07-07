import { LightningElement, api } from 'lwc';
export default class ChildComponent extends LightningElement {
    @api name;

    @api callFromParent(param) {
        alert('Clicked!! '+param)
    }
}