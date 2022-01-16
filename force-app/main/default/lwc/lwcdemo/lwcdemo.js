import { LightningElement, track } from 'lwc';

export default class App extends LightningElement {
    message;
    message1;
  firstName="";
  lastName="";
  areDetailsVisible=false;

  changeText(event) {
      const box=event.target.name;
      if(box=='txtFirst') {
          this.firstName=event.target.value;
      } else if(box=='txtLast') {
          this.lastName=event.target.value;
      }
      
      }
       handleClick(event) {
           this.message="Welcome to Lwc";
       }

       message1=false;

       handleClick1(event) {
           if(this.message1===false) {
               this.message1=true;
           }
           else {
               this.message1=false;
           }
        } 
        
        handleChange(event) {
            this.areDetailsVisible=event.target.checked;
        }
}