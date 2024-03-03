import { LightningElement } from 'lwc';
import getEmployeeData from '@salesforce/apex/EmployeeDetailsController.getEmployeeData';
const columns = [
    { label: 'Id', fieldName: 'id'},
    { label: 'Name', fieldName: 'employeeName'},
    { label: 'Age', fieldName: 'employeeAge'},
    { label: 'Salary', fieldName: 'employeeSalary'}
];
export default class EmployerComponent extends LightningElement {
    //https://dummy.restapiexample.com/#
    empId='';
    employeeDetails;
    empColumns = columns
     /* lwc connected callback lifecycle hook method */
     connectedCallback() {
        this.fireEmployeeRequest();
    }

    /* fire request */
    fireEmployeeRequest() {
        getEmployeeData({empId:this.empId})
            .then((response) => {
                this.publishResponse(response)   
            }).catch((err) => {
                this.error = err;
            });
    }

    /* handle response */
    publishResponse(response) {
        if(response.command.method == 'getEmployeeData') {
            this.processPointsResponse(response);
        }
    }

    processPointsResponse(response) {
        this.employeeDetails = response.details.data;
        console.log('emp response-->',JSON.stringify(this.employeeDetails));
    }


}