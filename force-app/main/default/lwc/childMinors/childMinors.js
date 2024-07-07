import { LightningElement, api } from 'lwc';
export default class ChildMinors extends LightningElement {

    minors = [
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

    sendMinors(){
        const minorsEvent = new CustomEvent("minorsdata",{
            detail : this.minors
        });
        this.dispatchEvent(minorsEvent);
    }

}