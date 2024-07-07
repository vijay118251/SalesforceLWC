import { LightningElement, api } from 'lwc';
export default class ChildStudents extends LightningElement {

    students = [];
    minors = [];
    show = false;
    showMinors = false;

    @api getFromParent(Students){
        this.show = true;
        this.students = Students;
        this.handleEvent();

    }

    @api getMinors(Minors){
        this.showMinors = true;
        this.minors = Minors;
    }

    handleEvent(){
        const studentsEvent = new CustomEvent("getstudents",{
            detail : this.students
        });
        this.dispatchEvent(studentsEvent);
    }

}