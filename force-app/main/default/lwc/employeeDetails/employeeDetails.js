import { LightningElement } from 'lwc';

export default class EmployeeDetails extends LightningElement {


    empDetails = [
        { empName: 'Steve,', empAdress: '123 Elm St' },
        { empName: 'John,', empAdress: '456 Oak St' },
        { empName: 'Jane,', empAdress: '789 Pine St' },
        { empName: 'Alice,', empAdress: '101 Maple St' },
        { empName: 'Bob,', empAdress: '202 Birch St' }
    ]
}