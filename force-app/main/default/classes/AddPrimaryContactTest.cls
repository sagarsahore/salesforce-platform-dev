@isTest
public class AddPrimaryContactTest {

    @isTest
    static void testAddPrimaryContactQueueable() {
        // Create 50 NY and 50 CA accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Account NY ' + i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'Account CA ' + i, BillingState = 'CA'));
        }
        insert accounts;

        // Base contact to clone
        Contact base = new Contact(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'test@example.com'
        );

        // Enqueue the job with state = CA
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(base, 'CA'));
        Test.stopTest();

        // Assert that exactly 50 contacts were created for CA accounts
        List<Contact> insertedContacts = [
            SELECT Id, Account.BillingState FROM Contact WHERE Account.BillingState = 'CA'
        ];

        System.assertEquals(50, insertedContacts.size(), 'Should have created 50 contacts for CA accounts');
    }
}