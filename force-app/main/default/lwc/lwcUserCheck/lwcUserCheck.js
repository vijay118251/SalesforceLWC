import { LightningElement } from 'lwc';
import userHasPermission from '@salesforce/apex/UserPermission.checkUserSettings';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LwcUserCheck extends LightningElement {
    userName;
    clicked=false;
    error;
    custPerm='userPermissions';

    handleClick() {
        userHasPermission({customPermissionName:this.custPerm})
        .then((result) => {
            this.clicked=true;
            this.userName=result;
            console.log('result-->',result);
        }).catch((err) => {
            this.clicked=false;
            console.log('error-->',err);
            this.ShowToast('You Don\'t Have Access',err.body ? err.body.message : err.statusText, 'error');
        });
    }

    ShowToast(title, message, variant){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant
            });
            this.dispatchEvent(evt);
    }

    handlerClick() {
        throw new Error('Whoops!');
    }
}