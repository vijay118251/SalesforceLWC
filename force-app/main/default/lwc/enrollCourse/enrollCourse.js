import { LightningElement,api } from 'lwc';

export default class EnrollCourse extends LightningElement {
    @api courseDetailInfo=
    {
    courseName:'Lightning Web Component',
    storage:'30 Days',
    Price:'Free', 
    Rating:'*****',
    }
 
}