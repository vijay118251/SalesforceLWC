import { LightningElement } from 'lwc';
const INITIAL_TIME=10;
export default class SetFunctionsLwc extends LightningElement {
    message = 'Initial Message';
    counter = INITIAL_TIME;
    intervalId;
    //The setTimeout method is used to execute a function after a specified delay.

    connectedCallback() {
        // Execute the changeMessage function after a delay of 2 seconds
        setTimeout(() => {
            this.changeMessage(new Date());
        }, 2000);

        this.intervalId = setInterval(() => this.incrementCounter(), 1000);
    }

    disconnectedCallback() {
        // Clear the interval when the component is disconnected to avoid memory leaks
        clearInterval(this.intervalId);
    }

    incrementCounter() {
        this.counter--;
        if(this.counter<=0) {
            this.showAlert();
        }
    }

    showAlert() {
        clearInterval(this.intervalId);
        alert('Time\'s Up')
    }

    changeMessage(newMessage) {
        this.message = newMessage;
    }
}