import { LightningElement,track } from 'lwc';
import WirelessCharger from '@salesforce/resourceUrl/WirelessCharger';
import BluetoothEarbuds from '@salesforce/resourceUrl/BluetoothEarbuds';
import PhoneCase from '@salesforce/resourceUrl/PhoneCase';
import ScreenProtector from '@salesforce/resourceUrl/ScreenProtector';
import PowerBank from '@salesforce/resourceUrl/PowerBank';
import PhoneStand from '@salesforce/resourceUrl/PhoneStand';
export default class TabLwc extends LightningElement {
    imageUrl1 = WirelessCharger;
    imageUrl2 = BluetoothEarbuds
    imageUrl3 = PhoneCase;
    imageUrl4 = ScreenProtector;
    imageUrl5 = PowerBank
    imageUrl6 = PhoneStand;
    @track deviceDetails=[
        {
          "name": "Wireless Charger",
          "category": "Charging",
          "price": 29.99,
          "brand": "Anker",
          "color": "Black",
          "imageUrl": this.imageUrl1,
          "compatible_with": ["iPhone", "Samsung", "Google Pixel"]
        },
        {
          "name": "Bluetooth Earbuds",
          "category": "Audio",
          "price": 79.99,
          "brand": "JBL",
          "color": "White",
          "battery_life": "12 hours",
          "imageUrl": this.imageUrl2,
          "compatible_with": ["iPhone", "Android"]
        },
        {
          "name": "Phone Case",
          "category": "Protection",
          "price": 15.99,
          "brand": "OtterBox",
          "color": "Blue",
          "imageUrl": this.imageUrl3,
          "compatible_with": ["iPhone 13", "iPhone 14"]
        },
        {
          "name": "Screen Protector",
          "category": "Protection",
          "price": 9.99,
          "brand": "ZAGG",
          "color": "Clear",
          "imageUrl": this.imageUrl4,
          "compatible_with": ["iPhone 13", "Samsung Galaxy S21"]
        },
        {
          "name": "Portable Power Bank",
          "category": "Charging",
          "price": 39.99,
          "brand": "Anker",
          "capacity": "10000mAh",
          "color": "Red",
          "imageUrl": this.imageUrl5,
          "compatible_with": ["iPhone", "Android"]
        },
        {
          "name": "Phone Stand",
          "category": "Accessories",
          "price": 12.99,
          "brand": "Lamicall",
          "color": "Silver",
          "imageUrl": this.imageUrl6,
          "compatible_with": ["iPhone", "iPad", "Android Phones"]
        }
      ];
      
}