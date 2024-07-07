import { LightningElement } from 'lwc';
export default class ParentMinors extends LightningElement {

    show = false;
    hide = false;
    minors = [];
    students = [];

    getMinors(event){
        this.show = true;
        this.minors = event.detail;
    }

    getStudents(event){
        this.hide = true;
        this.students = event.detail;
    }

}