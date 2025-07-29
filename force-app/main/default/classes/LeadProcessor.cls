public class LeadProcessor implements Database.Batchable<SObject> {
    
    // Start method - returns a QueryLocator for all Lead records
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }
    
    // Execute method - updates LeadSource to 'Dreamforce' for all records in scope
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Lead> leadsToUpdate = new List<Lead>();
        
        for (SObject record : scope) {
            Lead leadRecord = (Lead) record;
            leadRecord.LeadSource = 'Dreamforce';
            leadsToUpdate.add(leadRecord);
        }
        
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
    
    // Finish method - called after all batches are processed
    public void finish(Database.BatchableContext bc) {
        // Optional: Add any post-processing logic here
        System.debug('LeadProcessor batch job completed successfully');
    }
}