public class AddPrimaryContact implements Queueable {

    private Contact baseContact;
    private String stateAbbreviation;

    // Constructor
    public AddPrimaryContact(Contact contactToClone, String stateAbbreviation) {
        this.baseContact = contactToClone;
        this.stateAbbreviation = stateAbbreviation;
    }

    // Execute method
    public void execute(QueueableContext context) {
        // Query up to 200 Accounts with specified BillingState
        List<Account> accounts = [
            SELECT Id, Name FROM Account
            WHERE BillingState = :stateAbbreviation
            LIMIT 200
        ];

        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : accounts) {
            Contact clonedContact = baseContact.clone(false, false, false, false);
            clonedContact.AccountId = acc.Id;
            contactsToInsert.add(clonedContact);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}