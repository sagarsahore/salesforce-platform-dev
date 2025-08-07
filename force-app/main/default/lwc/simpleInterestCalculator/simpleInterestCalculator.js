import { LightningElement,track } from 'lwc';

export default class SimpleInterestCalculator extends LightningElement {
@track currentOutput;
@track principle;
@track rateOfInterest;
@track time;

handlePrincipleChange(event) {
    this.principle = event.target.value;
    
}

handleRateOfInterestChange(event) {
    this.rateOfInterest = event.target.value;

}

handleTimeChange(event) {
    this.time = event.target.value;

}

handleCalculate() {
    const interest = (this.principle * this.rateOfInterest * this.time) / 100;
    this.currentOutput = `The simple interest is ${interest}`;
}

renderedCallback() {
    if (this.currentOutput) {
        const outputElement = this.template.querySelector('.output');
        outputElement.scrollIntoView({ behavior: 'smooth' });
    }
}   

}