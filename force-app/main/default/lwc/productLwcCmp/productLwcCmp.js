import { LightningElement } from 'lwc';
import fetchProductDetails from '@salesforce/apex/ProductElementController.getProductDetails';
export default class ProductLwcCmp extends LightningElement {
    title='PRODUCT'
    product = 'objects';
    products=[];
    filteredProducts;
    error;
    productNo='2';

    connectedCallback() {
        this.productCallout();
    }

    productCallout() {
        fetchProductDetails({ product: this.product })
            .then((result) => {
                this.hadleReponse(result);
            })
            .catch((error) => {
                this.error = error;
                this.products = undefined;
            });
    }

    hadleReponse(response) {
        let productDetails = response.details;
        if(productDetails!=null &&productDetails.length>0) {
            productDetails.forEach(Item => {
                //Item.brand=Item.name;
                //Item.cost='$75000';
                Item.data={...Item.data, brand:Item.name, cost: '$67767'};

            });
        console.log('OUTPUT-->: ',productDetails);
        this.products = productDetails;
        let filterItem = this.products.find((element) => element.id=='3');
        this.filteredProducts={...filterItem, storage:'128 GB'};
        console.log('Filtered-->',JSON.stringify(this.filteredProducts));
        }
        else {
            productDetails='No Product Found';
        }
    }
    
}