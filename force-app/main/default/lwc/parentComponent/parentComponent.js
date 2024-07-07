import { LightningElement } from 'lwc';
export default class ParentComponent extends LightningElement {
    Name;
    handleName(event){
        this.Name = event.target.value;
    }

    callChildMethod(){
        let child = this.template.querySelector('c-child-component');
        child.callFromParent(this.Name);
    }

}