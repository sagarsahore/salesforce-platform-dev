global public class AccountUpdateNullValueBatch  implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Name FROM Account WHERE Name = NULL'
        );
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        for (SObject s : scope) {
            Account a = (Account)s;
            a.Name = 'Updated Name'; // Set a new name
            accountsToUpdate.add(a);
        }
        update accountsToUpdate;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Account name update batch process completed.');
    }
}

