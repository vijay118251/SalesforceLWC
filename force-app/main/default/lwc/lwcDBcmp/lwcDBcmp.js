import { LightningElement,api } from 'lwc';
const columns = [
    { label: 'Name', fieldName: 'name'},
    { label: 'Cpu Model', fieldName: 'cpuModel'},
    { label: 'Hard Disk', fieldName: 'hardDisk'},
    { label: 'Price', fieldName: 'price'},
    { label: 'Year', fieldName: 'year'},
];
export default class LwcDBcmp extends LightningElement {

    @api externalResponse;
    columns = columns;

    handleClick() {
        console.log('handle Button called');
        console.log('externalResponse : ',externalResponse);
        let extData = JSON.parse(JSON.stringify(externalResponse));
        console.log('extData : ',extData);
    }

}