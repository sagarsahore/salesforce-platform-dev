import { LightningElement, track } from 'lwc';

export default class FirstExample extends LightningElement {
    @track Greeting = 'Hello World!';
    changeHandler(event) {
        this.Greeting = event.target.value;
    }
}