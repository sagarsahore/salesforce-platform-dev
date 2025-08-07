import { LightningElement,track } from 'lwc';

export default class ShapeCalculator extends LightningElement {
    @track currentOutput;
    width;
    height;
    side;
    diagonal1;
    diagonal2;

    sideChangeHandler(event) {
        this.side = event.target.value;
    }
    widthChangeHandler(event) {
        this.width = event.target.value;
    }
    heightChangeHandler(event) {
        this.height = event.target.value;
    }
    diagonal1ChangeHandler(event) {
        this.diagonal1 = event.target.value;
    }
    diagonal2ChangeHandler(event) {
        this.diagonal2 = event.target.value;
    }   

    calculateSqAreaHandler() {
        const area = this.side * this.side;
        this.currentOutput = `The area of the square is ${area}`;
    }

    calculateRecAreaHandler() {
        const area = this.width * this.height;
        this.currentOutput = `The area of the rectangle is ${area}`;
    }

    calculateRhAreaHandler() {
        const area = (this.diagonal1 * this.diagonal2) / 2;
        this.currentOutput = `The area of the rhombus is ${area}`;
    }
}