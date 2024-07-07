import { LightningElement,api } from 'lwc';
import saveToDoTask from '@salesforce/apex/SaveToDoTaskController.saveToDoTask';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class CreateTask extends LightningElement {
    taskTitle;
    dueDate;

    @api targetParent;

    showDueDate = false;
    showSaveButton = false;

    handleOnChange(event){
        const fieldName = event.target.name;
        if(fieldName === 'taskTitle'){
            this.taskTitle = event.target.value;
            this.taskTitle != "" ? this.showDueDate = true : this.showDueDate = false;
        }
        else if(fieldName === 'dueDate'){
            this.dueDate = event.target.value;
            this.dueDate != "" && this.targetParent != true ? this.showSaveButton = true : this.showSaveButton = false;
        }
    }

    handleClick(){
        console.log("@@@Button click on child");
        saveToDoTask({title: this.taskTitle, dueDate: this.dueDate})
        .then((result) => {
            if(result === "Success"){
                this.taskTitle = "";
                this.dueDate = "";

                const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Task has been added successfully',
                    variant: 'success'
                });
                this.dispatchEvent(evt);
            }
        })
        .catch((error) => {
            console.log("error: ",error);

            const evt = new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(evt);
        });
    }

    @api 
    handleParentClick(){
        this.handleClick();
    }


}