import { LightningElement } from 'lwc';

export default class BmiCalculator extends LightningElement {
    height='';
    weight='';
    bmiValue='';
    result='';

    inputHandler(event) {
        const {name,value} = event.target;
        if(name==='height') {
            this.height=value;
        }
        if(name==='weight') {
            this.weight=value;
        }
    }

    submitHandler(event) {
        event.preventDefault();
        console.log(`Height: ${this.height} and Weight: ${this.weight}`);
        this.calculate();
    }

    calculate() {
        //BMI: weight in KG / (height in m * height in m)
        let height = Number(this.height)/100;
        let bmi = Number(this.weight)/ (height*height);
        this.bmiValue = Number(bmi.toFixed(2));
        this.result = this.bmiValue < 18.5 ? 'UnderWeight' : this.bmiValue >= 18.5 && this.bmiValue < 25 ? 'Healthy' 
        : this.bmiValue >= 25 && this.bmiValue < 30 ? 'OverWeight' : 'Obese';
        console.log(`BMI Value is: ${this.bmiValue}`);
        console.log(`Result is: ${this.result}`);
    }

    recalculate() {
        this.result='';
        this.bmiValue='';
        this.height='';
        this.weight='';
    }
}