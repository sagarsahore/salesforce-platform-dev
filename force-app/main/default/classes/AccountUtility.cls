public class AccountUtility {
    
    public void createSingleAccount(String n, String bc)
    {
        Account acc = new Account(Name=n, billingCity=bc);
        insert acc;
        System.debug('One Account got created Succesfully' +acc.id);
    }

}