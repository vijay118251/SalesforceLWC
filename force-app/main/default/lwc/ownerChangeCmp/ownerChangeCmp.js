import { LightningElement } from 'lwc';

export default class OwnerChangeCmp extends LightningElement {
    objectApiName = 'User';

    filter = {
        criteria: [
            {
                fieldPath: 'IsActive',
                operator: 'eq',
                value: 'true'
            }
        ]
    };

    handleChange(event) {
        console.log(event);
    }
}