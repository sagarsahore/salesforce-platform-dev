@isTest
public class AccountProcessorTest {
    @isTest
    static void testCountContacts() {
        // Create 2 Accounts
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{ acc1, acc2 };

        // Add 2 Contacts to acc1 and 1 to acc2
        insert new List<Contact>{
            new Contact(FirstName = 'A', LastName = 'One', AccountId = acc1.Id),
            new Contact(FirstName = 'B', LastName = 'Two', AccountId = acc1.Id),
            new Contact(FirstName = 'C', LastName = 'Three', AccountId = acc2.Id)
        };

        // Run the future method
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc1.Id, acc2.Id});
        Test.stopTest();

        // Query to validate the field
        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :new List<Id>{acc1.Id, acc2.Id}];
        for (Account acc : updatedAccounts) {
            if (acc.Id == acc1.Id) {
                System.assertEquals(2, acc.Number_Of_Contacts__c);
            } else if (acc.Id == acc2.Id) {
                System.assertEquals(1, acc.Number_Of_Contacts__c);
            }
        }
    }

    @isTest
    static void testEmptyList() {
        // Ensure coverage for the early return line
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>());
        Test.stopTest();
    }
}