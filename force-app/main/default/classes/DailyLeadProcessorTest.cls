@isTest
public class DailyLeadProcessorTest {
    
    @testSetup
    static void setupTestData() {
        // Create 200 Lead records with blank LeadSource for testing
        List<Lead> testLeads = new List<Lead>();
        
        for (Integer i = 0; i < 200; i++) {
            Lead testLead = new Lead(
                FirstName = 'Test',
                LastName = 'Lead ' + i,
                Company = 'Test Company ' + i,
                Email = 'test' + i + '@example.com'
                // LeadSource is intentionally left null/blank
            );
            testLeads.add(testLead);
        }
        
        insert testLeads;
    }
    
    @isTest
    static void testDailyLeadProcessor() {
        // Verify initial state - leads should have blank LeadSource
        List<Lead> initialLeads = [SELECT Id, LeadSource FROM Lead];
        System.assertEquals(200, initialLeads.size(), 'Should have 200 test leads');
        
        for (Lead lead : initialLeads) {
            System.assertEquals(null, lead.LeadSource, 'Initial LeadSource should be blank');
        }
        
        Test.startTest();
        
        // Schedule the DailyLeadProcessor to run
        String cronExpression = '0 0 0 * * ?'; // Daily at midnight
        String jobName = 'Test Daily Lead Processor';
        
        DailyLeadProcessor scheduler = new DailyLeadProcessor();
        System.schedule(jobName, cronExpression, scheduler);
        
        // Manually execute the scheduled job for testing
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify that all leads have been updated with LeadSource = 'Dreamforce'
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead];
        System.assertEquals(200, updatedLeads.size(), 'Should still have 200 leads');
        
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
    
    @isTest
    static void testDailyLeadProcessorWithNoBlankLeads() {
        // Update all leads to have a LeadSource value
        List<Lead> existingLeads = [SELECT Id FROM Lead];
        for (Lead lead : existingLeads) {
            lead.LeadSource = 'Web';
        }
        update existingLeads;
        
        Test.startTest();
        
        DailyLeadProcessor scheduler = new DailyLeadProcessor();
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify no leads were changed (all already had LeadSource values)
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead];
        for (Lead lead : leads) {
            System.assertEquals('Web', lead.LeadSource, 'LeadSource should remain Web');
        }
    }
    
    @isTest
    static void testDailyLeadProcessorWithMoreThan200Leads() {
        // Add 50 more leads to test the LIMIT 200 functionality
        List<Lead> additionalLeads = new List<Lead>();
        
        for (Integer i = 200; i < 250; i++) {
            Lead testLead = new Lead(
                FirstName = 'Additional',
                LastName = 'Lead ' + i,
                Company = 'Additional Company ' + i,
                Email = 'additional' + i + '@example.com'
                // LeadSource is intentionally left null/blank
            );
            additionalLeads.add(testLead);
        }
        
        insert additionalLeads;
        
        // Verify we have 250 total leads
        List<Lead> allLeads = [SELECT Id FROM Lead];
        System.assertEquals(250, allLeads.size(), 'Should have 250 total leads');
        
        Test.startTest();
        
        DailyLeadProcessor scheduler = new DailyLeadProcessor();
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify only 200 leads were updated (due to LIMIT 200)
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Only 200 leads should be updated due to LIMIT');
        
        List<Lead> remainingBlankLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null];
        System.assertEquals(50, remainingBlankLeads.size(), '50 leads should still have blank LeadSource');
    }
    
    @isTest
    static void testSchedulableInterface() {
        // Test that the class properly implements Schedulable interface
        DailyLeadProcessor processor = new DailyLeadProcessor();
        
        Test.startTest();
        
        // Test execute method with SchedulableContext
        String cronExpression = '0 0 1 * * ?'; // Daily at 1 AM
        String jobName = 'Interface Test Job';
        
        System.schedule(jobName, cronExpression, processor);
        
        // Manually call execute to test the method
        processor.execute(null);
        
        Test.stopTest();
        
        // Verify the scheduled job was created and leads were processed
        List<Lead> processedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, processedLeads.size(), 'Should process 200 leads');
    }
    
    @isTest
    static void testEmptyLeadDatabase() {
        // Delete all leads to test empty scenario
        delete [SELECT Id FROM Lead];
        
        Test.startTest();
        
        DailyLeadProcessor scheduler = new DailyLeadProcessor();
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify no errors occurred with empty dataset
        List<Lead> leads = [SELECT Id FROM Lead];
        System.assertEquals(0, leads.size(), 'Should have no leads');
    }
}