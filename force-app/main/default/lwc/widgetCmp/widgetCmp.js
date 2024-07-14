import { LightningElement, track } from 'lwc';
import getcategory from '@salesforce/apex/categoryController.getcategory';
export default class WidgetCmp extends LightningElement {
    response = {
        "batter": [
        {
            "id": "1001",
            "type": "Sandwich"
        },
        {
            "id": "1002",
            "type": "Chocolate"
        },
        {
            "id": "1003",
            "type": "Blueberry"
        },
        {
            "id": "1004",
            "type": "FrenchFries"
        }
        ]
    };

    @track list =[];

    connectedCallback() {
        let parseResp = JSON.parse(JSON.stringify(this.response));
        let batters = parseResp.batter;
        batters.forEach(batter => {
            let data = {};
            data.Id =  batter.id;
            data.type = batter.type;
            data.subCategory = 'Snacks';
            this.checkCategory(batter.type)
                .then(category => {
                    data.category = category;
                    this.list = [...this.list, data];
                    console.log('LIST-->',JSON.parse(JSON.stringify(this.list)));
                });
        });
    }

    async checkCategory(categoryType) {
        let productCategory;
        let category = await getcategory({type:categoryType});
        console.log('category-->',category);
        if(category === 'Fast Food') {
            productCategory = 'Fast Food';
        } else if(category === 'Juice') {
            productCategory = 'Juice';
        } else {
            productCategory = 'Cafe';
        }
        return productCategory;
    }
}