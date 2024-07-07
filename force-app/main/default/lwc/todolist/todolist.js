import { LightningElement, wire } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getToDoList from '@salesforce/apex/SaveToDoTaskController.getToDoList';

export default class ToDoList extends LightningElement {

    toDoList;
    taskStatus = 'Pending';
    // @wire(getToDoList, { taskStatus: '$taskStatus' })
    // wiredToDoList({ error, data }) {
    //   if (data) {
    //     console.log('Data', data);
    //     this.toDoList = data;
    //   } else if (error) {
    //      console.error('Error:', error);
         
    //      const evt = new ShowToastEvent({
    //                 title: 'Error',
    //                 message: error.body.message,
    //                 variant: 'error'
    //             });
    //             this.dispatchEvent(evt);
    //   }
    // }

    @wire(getToDoList, { taskStatus: '$taskStatus' })
    wiredToDoList(result) {
        this.wiredToDoListResult = result;
        if (result.data) {
            console.log('Data', data);
            this.toDoList = data;
        } else if (result.error) {
            console.error('Error:', error);
            
            const evt = new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    });
                    this.dispatchEvent(evt);
        }
    }



}