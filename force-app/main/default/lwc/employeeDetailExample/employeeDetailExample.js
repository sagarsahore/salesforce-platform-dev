import { LightningElement, track } from 'lwc';

export default class EmployeeDetailExample extends LightningElement {
    @track employeeName;
    @track employeeId;
    @track department;
    @track location;
    @track email;   

    nameHandler(event) {
        this.employeeName = event.target.value;
    }
    nameHandler(event) {
        this.employeeId = event.target.value;
    }
    departmentHandler(event) {
        this.department = event.target.value;
    }
    locationHandler(event) {
        this.location = event.target.value;
    }
    emailHandler(event) {       
        this.email = event.target.value;
    }
    submitHandler() {
        const employeeDetails = {
            employeeName: this.employeeName,
            employeeId: this.employeeId,
            department: this.department,
            location: this.location,
            email: this.email
        };
        console.log('Employee Details:', JSON.stringify(employeeDetails));
    }

}