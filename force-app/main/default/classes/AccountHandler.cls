public class AccountHandler {

    public static Account insertNewAccount(String accountName) {
         try {
            // Handle empty string case
            if (String.isBlank(accountName)) {
                Account emptyAccount = new Account(Name = '');
                insert emptyAccount;
                return emptyAccount;
            }
            
            // Create and insert account with provided name
            Account newAccount = new Account(Name = accountName);
            insert newAccount;
            return newAccount;
        } catch (DmlException e) {
            // Catch DML exceptions and return null
            System.debug('DML Exception occurred: ' + e.getMessage());
            return null;
        }
    }

}     
