@isTest
public class LeadProcessorTest {
    
    @testSetup
    static void setupTestData() {
        // Create 200 Lead records for testing
        List<Lead> testLeads = new List<Lead>();
        
        for (Integer i = 0; i < 200; i++) {
            Lead testLead = new Lead(
                FirstName = 'Test',
                LastName = 'Lead ' + i,
                Company = 'Test Company ' + i,
                Email = 'test' + i + '@example.com',
                LeadSource = 'Web' // Initial LeadSource value
            );
            testLeads.add(testLead);
        }
        
        insert testLeads;
    }
    
    @isTest
    static void testLeadProcessor() {
        // Verify initial state - leads should have 'Web' as LeadSource
        List<Lead> initialLeads = [SELECT Id, LeadSource FROM Lead];
        System.assertEquals(200, initialLeads.size(), 'Should have 200 test leads');
        
        for (Lead lead : initialLeads) {
            System.assertEquals('Web', lead.LeadSource, 'Initial LeadSource should be Web');
        }
        
        // Start the batch job
        Test.startTest();
        
        LeadProcessor batchJob = new LeadProcessor();
        Id jobId = Database.executeBatch(batchJob);
        
        Test.stopTest();
        
        // Verify that all leads have been updated with LeadSource = 'Dreamforce'
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead];
        System.assertEquals(200, updatedLeads.size(), 'Should still have 200 leads');
        
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
    
    @isTest
    static void testLeadProcessorWithNoLeads() {
        // Delete all leads to test empty scenario
        delete [SELECT Id FROM Lead];
        
        Test.startTest();
        
        LeadProcessor batchJob = new LeadProcessor();
        Id jobId = Database.executeBatch(batchJob);
        
        Test.stopTest();
        
        // Verify no errors occurred with empty dataset
        List<Lead> leads = [SELECT Id FROM Lead];
        System.assertEquals(0, leads.size(), 'Should have no leads');
    }
    
    @isTest
    static void testBatchableInterface() {
        // Test that the class properly implements Database.Batchable interface
        LeadProcessor processor = new LeadProcessor();
        
        Test.startTest();
        
        // Test start method
        Database.BatchableContext bc = null; // Mock context for testing
        Database.QueryLocator ql = processor.start(bc);
        System.assertNotEquals(null, ql, 'QueryLocator should not be null');
        
        // Test execute method with a small scope
        List<Lead> testScope = [SELECT Id, LeadSource FROM Lead LIMIT 5];
        if (!testScope.isEmpty()) {
            processor.execute(bc, testScope);
            
            // Verify the leads in scope were updated
            List<Lead> updatedScope = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testScope];
            for (Lead lead : updatedScope) {
                System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated');
            }
        }
        
        // Test finish method
        processor.finish(bc);
        
        Test.stopTest();
    }
}