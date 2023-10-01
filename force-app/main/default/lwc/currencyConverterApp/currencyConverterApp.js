import { LightningElement } from 'lwc';
import {countryCodeList} from 'c/countryCodeList';
import currencyConverterAssets from '@salesforce/resourceUrl/currencyConverterAssets'
export default class CurrencyConverterApp extends LightningElement {
    currencyImage = currencyConverterAssets +'/currencyConverterAssets/currency.svg'
    countryList = countryCodeList;
    countryFrom='INR';
    countryTo='USD';
    amount ='';
    result;
    error;

    handleChange(event) {
        const {name,value} = event.target;
        console.log(`from: ${name} and to: ${value}`);
        this[name]=value;
        this.result='';
        this.error='';
    }

    submitHandler(event) {
        event.preventDefault();
        this.convert();
    }

    async convert(){
        const API_URL = `https://api.exchangerate.host/convert?from=${this.countryFrom}&to=${this.countryTo}`
        try{
          const data = await fetch(API_URL);
          const jsonData = await data.json();
          console.log('response-->',jsonData);
          this.result = (Number(this.amount) * jsonData.result).toFixed(5);
          console.log(this.result);
        } catch(error){
          console.log(error);
          this.error="An error occurred. Please try again...";
        }
      }
}