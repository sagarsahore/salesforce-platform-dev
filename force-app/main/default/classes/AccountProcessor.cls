public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) return;

        // Count the number of contacts per account
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        for (AggregateResult result : [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put((Id)result.get('AccountId'), (Integer)result.get('contactCount'));
        }

        // Prepare list of accounts to update
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            Integer count = contactCountMap.containsKey(accountId) ? contactCountMap.get(accountId) : 0;
            accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = count));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}