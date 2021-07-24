import { LightningElement,track,wire } from 'lwc';
import getTaskList from'@salesforce/apex/taskController.getTaskList';
import { refreshApex } from '@salesforce/apex';
import insertTask from '@salesforce/apex/taskController.insertTask';
import deleteTask from '@salesforce/apex/taskController.deleteTask';

export default class Todolist1 extends LightningElement {
    @track
    todoTasks = [];
    newTask = '';
    click=false;
    spinner = true;

    updateNewTask(event) {
        this.newTask = event.target.value;
    }

    addTaskToList(event) {
        if(this.newTask=='') {
            return;
        }
        this.spinner=true;
        insertTask({ name: this.newTask })
        .then(result => {
            this.spinner=false;
            console.log(result);
            // * Push function - used to add element at the end of the array
            this.todoTasks.push({
                id: this.todoTasks[this.todoTasks.length - 1] ? this.todoTasks[this.todoTasks.length - 1].id + 1 : 0,
                name: this.newTask,
                recordId: result.Id
            });
            this.newTask = '';
            console.log(JSON.stringify(this.todoTasks));
        })
        .catch(error => console.log(error))
    }

    handleClick(event){
        if(this.click==event.target.checked) {
            alert("Task Over");
        }
    }
    deleteTaskFromList(event) {

        let idToDelete = event.target.name;
        let todoTasks = this.todoTasks;
        let todoTaskIndex;
        let recordIdToDelete;
        this.spinner=true;
        /*
        *   Method 1 - Finding the index of the task to be deleted
        *   and deleting it using the below command
        */
        for(let i=0; i<todoTasks.length; i++) {
            if(idToDelete === todoTasks[i].id) {
                todoTaskIndex = i;
            }
        }

        recordIdToDelete = todoTasks[todoTaskIndex].recordId;
        console.log(recordIdToDelete);
        deleteTask({ recordId: recordIdToDelete })
        .then(result => {
            this.spinner=false;
            console.log(result);
            if(result) {
                
                todoTasks.splice(todoTaskIndex, 1);
            } else {
                console.log('Unable to delete task');
            }
            console.log(JSON.stringify(this.todoTasks));
        })
        .catch(error => console.log(error))

    }
    @wire(getTaskList)
    getTodoTasks(response) {
        this.todoTasksResponse = response;
        let data = response.data;
        let error = response.error;
        if(data || error) {
            this.spinner = false;
        }


        if(data) {
            console.log('data');
            console.log(data);
            this.todoTasks = [];
            data.forEach(task => {
                this.todoTasks.push({
                    id: this.todoTasks.length + 1,
                    name: task.Name,
                    recordId: task.Id
                });
            });
        } else if(error) {
            console.log('error');
            console.log(error);
       }
    }


    refreshTodoList() {
        this.spinner = true;
        /*
        *   It'll refresh the data in browser cache only
        *   if there is a change on the server side
        */
        refreshApex(this.todoTasksResponse)
        .finally(() => this.spinner = false);
    }

}