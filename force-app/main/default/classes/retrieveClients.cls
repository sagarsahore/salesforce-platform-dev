//Q2. Retrieve all KiwiSaver clients from Account and display their fund type.
public with sharing class RetrieveClients {
    
    public RetrieveClients() {
        getKiwiSaverClients();
    }
    
    // Method to retrieve KiwiSaver clients
    public void getKiwiSaverClients() {
        List<Account> myClients = [
            SELECT Id, Name, KiwiSaver_Fund__c 
            FROM Account
            WHERE IsKiwiSaver__c = TRUE
            LIMIT 100
        ];
        
        if (myClients.isEmpty()) {
            System.debug('No KiwiSaver clients found.');
        } else {
            for (Account myClient : myClients) {
                System.debug(
                    String.format(
                        'Client ID: {0}, Name: {1}, KiwiSaver Fund: {2}', 
                        new List<Object>{ myClient.Id, myClient.Name, myClient.KiwiSaver_Fund__c }
                    )
                );
            }
        }
    }
}
