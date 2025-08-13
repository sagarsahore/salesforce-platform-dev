//Q3. Given List<Contact> cons from a query, build a List<Id> of non-null 
//AccountId values in the same order as the contacts. (Don’t use sets or maps—List only.)
public with sharing class listContact {
    public listContact() {

    }
    // Method to list contact names
    public static void listContactNames() {
        List<id> accountIds = new List<Id>();
        List<Contact> contactList = [
            SELECT Id, AccountId FROM Contact
            WHERE AccountId != NULL
        ];

        for (Contact con: contactList) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }
}