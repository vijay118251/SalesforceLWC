import { LightningElement } from 'lwc';
export default class ParentStudents extends LightningElement {

    minors = [];

    students = [
        {
            'Name': 'Deepika',
            'Id': 1779109,
            'Age': 25
        },
        {
            'Name': 'Vijay',
            'Id': 1998632,
            'Age':24
        },
        {
            'Name': 'Deepu',
            'Id': 1779110,
            'Age':16
        },
        {
            'Name': 'Viju',
            'Id': 1998633,
            'Age':15
        }
    ];

    callChildMethod(){
        let child = this.template.querySelector('c-child-students');
        child.getFromParent(this.students)
    }

    sendMinors(){
        let childd = this.template.querySelector('c-child-students');
        if(!this.minors.length){
            this.students.forEach(student => {
            if(student.Age <= 18){
                this.minors.push(student);
            }
        });
        childd.getMinors(this.minors);
        }     
    }
}