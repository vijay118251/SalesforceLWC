import { LightningElement,api,track,wire } from 'lwc';
import mapMethod from '@salesforce/apex/VehicleMapController.mapMethod';
export default class LwcVehicleInterest extends LightningElement {

@api recordId;
error;
@api componentLabel;
@track vehicleList=[];
@track vehicleKey=[];
displayDetails=false;
vehicleObj;
vehicleMap=[];

connectedCallback() {
    this.fetchVehicleInterestDetails();
}

fetchVehicleInterestDetails() {
    mapMethod({accId:this.recordId})
    .then((response) => {
        this.handleCallback(response);
    })
    .catch((error) => {
        this.error = error;
        this.vehicleData = undefined;
    });
}

    handleCallback(response){
        this.publishResponse(response);
    }
    publishResponse(response) {
        console.log('response-->',JSON.stringify(response));
        if(response.details!=null) {
        this.displayDetails = true;
        let vehicleRecs = response.details;
        this.vehicleObj = Object.values(vehicleRecs);
        console.log('object:',JSON.stringify(this.vehicleObj));
        for(let key in vehicleRecs) {
            this.vehicleMap.push({key:key, value:vehicleRecs[key]});
        }
        }
        console.log('map-->',JSON.stringify(this.vehicleMap));
        if(this.vehicleMap!=null && this.vehicleMap.length>0) {
            this.vehicleMap.forEach(item => {
                this.vehicleKey.push(item.key);
                this.vehicleList.push(item.value);
            });
            console.log('list::',JSON.stringify(this.vehicleKey));
            console.log('list::',JSON.stringify(this.vehicleList));
        }
        this.error=undefined;
    }


}