public class batchApexExample implements Database.Batchable<SObject> {
    public batchApexExample() {

    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Current_Balance__c, Fund_Type__c FROM KiwiSaver__c'
        );
    }
    
    public void execute(Database.BatchableContext bc, List<KiwiSaver__c> scope) {
        for(KiwiSaver__c k : scope) {
            k.Projected_Balance__c = k.Current_Balance__c * 1.05; // Example projection
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('KiwiSaver balance recalculation completed!');
    }
}

