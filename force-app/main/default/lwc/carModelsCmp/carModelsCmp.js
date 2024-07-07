import { LightningElement } from 'lwc';
import fetchMetadataDetails from '@salesforce/apex/MetadataCarPageController.selectCarPage';
import CAR_LOGO from '@salesforce/resourceUrl/carLogo';
import BMW_LOGO from '@salesforce/resourceUrl/bmwIcon';
export default class CarModelsCmp extends LightningElement {
    bodyValue=[''];
    fuelValue=[''];
    pageName='Car';
    carResponse;
    carModels=[];
    error;
    showCar=false;
    logo = BMW_LOGO;
    get bodyType() {
        return [
            { label: 'Sedan', value: 'Sedan' },
            { label: 'Gran Coupe', value: 'GranCoupe' },
            { label: 'Sports Activity Vehicle', value: 'SportActivityVehicle' },
        ];
    }

    get fuelType() {
        return [
            { label: 'Petrol', value: 'Petrol' },
            { label: 'Diesel', value: 'Diesel' },
            { label: 'Electric', value: 'Electric' },
        ];
    }

    handleChange(e) {
        this.value = e.target.value;
    }

    get selectedValues() {
        return this.value.join(',');
    }

    resetMethod(event) {
        this.bodyValue='';
        this.fuelValue='';
    }

    connectedCallback() {
        this.callout();
    }

    callout() {
        fetchMetadataDetails({ pageName: this.pageName })
            .then((response) => {
                console.log(response);
                this.error = undefined;
                this.publishResponse(response)
            })
            .catch((error) => {
                this.error = error;
                this.carResponse = undefined;
            });
    }

    /* handle response */
    publishResponse(response) {
        if(response.command.method == 'selectCarPage') {
            this.processCarResponse(response);
        }
    }

    /* process response */
    processCarResponse(response) {
        this.carResponse = response.carDetails;
        console.log('processCarResponse-->',JSON.stringify(this.carResponse));
        this.showCar = true;
        this.handleResponse();
    }

    /* handle response */
    handleResponse() {
        if(this.carResponse) {
            let parsedCarResponse = JSON.parse(JSON.stringify(this.carResponse));
            //this.carModels = Object.values(parsedCarResponse);
            for (let x in parsedCarResponse) {
                this.carModels.push(parsedCarResponse[x]);
            }
            this.setCarLogo();
        }
    }

    setCarLogo() {
        this.carModels = [...this.carModels].map(item => {
                        return {...item,source:CAR_LOGO + '/' + item.carLogo__c};
                });
        console.log('Logo Response-->',JSON.stringify(this.carModels));
    }

    handleOnIconClick(event) {
        console.log('img clicked',event.currentTarget.dataset.label);
    }

}