import { LightningElement } from 'lwc';

export default class PromiseCmp extends LightningElement {
result='';
error=''; 

connectedCallback() {}
async handleResponse(clickedButton) {
    try {
        this.result = await this.resp(clickedButton);
    } catch (error) {
        this.error=error;
    }
}

resp(clickedButton){
   return new Promise((resolve,reject)=> {
        if(clickedButton == 'Success'){
            resolve(clickedButton);
        }
        else{
            reject(clickedButton);
        }
   });
}

handleClick() {
    let clickedButton;
    [...this.template.querySelectorAll('lightning-button')]
    .forEach((item)=>{
        if(item.name='Success') {
            clickedButton='Success'
        } else {
            clickedButton='Fail'
        }
    })
    this.handleResponse(clickedButton);
}
}