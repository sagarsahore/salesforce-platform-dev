// Q3.Run a SOQL to get up to 50 Accounts. Using only a List<Account>, print the first 10 account names without causing an index error (handle lists shorter than 10).
public with sharing class retriveAccountList {
    public retriveAccountList() {
        getAccountList();

    }

    public static void getAccountList(){
        List <Account> accList = [
            SELECT Name FROM Account LIMIT 50
        ];
        for (Account acc : accList) {
            System.debug('Account Name: ' + acc.Name);
        }
    }
}