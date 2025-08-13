// Q3.Run a SOQL to get up to 50 Accounts. Using only a List<Account>, print the first 10 account names without causing an index error (handle lists shorter than 10).
public with sharing class retriveAccountList {
    public retriveAccountList() {
        getAccountList();

    }

    public static void getAccountList(){
        List <Account> accList = [
            SELECT Name FROM Account LIMIT 50
        ];
        // to get first 10 Accounts we used Math Min
         Integer toPrint = Math.min(10, accList.size());
        for (Integer i = 0; i < toPrint; i++) {
            System.debug('Account Name: ' + accList[i].Name);
    }
}