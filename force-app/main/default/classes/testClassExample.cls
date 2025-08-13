/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class testClassExample {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
    }
 
    @isTest
    static void testContactTriggerWithSystemEquals() {
        // Test case using System.assertEquals
        // Create a new contact without setting FirstName and LastName
        Contact testContact = new Contact();
        insert testContact;
        // Retrieve the contact from the database to ensure trigger
        // logic is applied
        Contact insertedContact = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :testContact.Id];
        // Verify that the trigger correctly set the standard field values
        // using System.assertEquals
                System.assertEquals('Max', insertedContact.FirstName, 'FirstName should be set to "Max".');
                System.assertEquals('Blank', insertedContact.LastName, 'LastName should be set to "Blank".');
    }
    @isTest
    static void testContactTriggerWithSystemAssertNotEquals() {
        // Test case using System.assertNotEquals
        // Create a new contact without setting FirstName and LastName
        Contact testContact = new Contact();
        insert testContact;
        // Retrieve the contact from the database to ensure trigger logic
        // is applied
        Contact insertedContact = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :testContact.Id];
        // Verify that the trigger did not set unexpected values using
        // System.assertNotEquals
        System.assertNotEquals('Unexpected Value', insertedContact.FirstName, 'FirstName should not be "Unexpected Value".');
        System.assertNotEquals('Unexpected Value', insertedContact.LastName, 'LastName should not be "Unexpected Value".');
    }
    @isTest
    static void testContactTriggerWithSystemAssert() {
        // Test case using System.assert
        // Create a new contact without setting FirstName and LastName
        Contact testContact = new Contact();
        insert testContact;
        // Retrieve the contact from the database to ensure trigger logic
        // is applied
        Contact insertedContact = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :testContact.Id];
        // Verify that the trigger correctly set the standard field values
        // using System.assert
            System.assert(insertedContact.FirstName == 'Max', 'FirstName should be set to "Max".');
            System.assert(insertedContact.LastName == 'Blank', 'LastName should be set to "Blank".');
    }
}

