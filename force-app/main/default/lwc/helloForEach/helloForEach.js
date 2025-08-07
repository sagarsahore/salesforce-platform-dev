import { LightningElement } from 'lwc';

export default class HelloForEach extends LightningElement {
    Contacts = [
        { id: '1', Name: 'John Doe', Title: 'Software Engineer' },
        { id: '2', Name: 'Jane Smith', Title: 'Product Manager' },
        { id: '3', Name: 'Alice Johnson', Title: 'UX Designer' },
        { id: '4', Name: 'Bob Brown', Title: 'Data Scientist' },
        { id: '5', Name: 'Charlie White', Title: 'Sales Executive' }
    ];


}