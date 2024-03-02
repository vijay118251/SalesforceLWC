import { LightningElement } from 'lwc';

export default class ComponentA extends LightningElement {
    greeting = 'World';
    changeHandler(event) {
      this.greeting = event.target.value;

    }
}