trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    // Create a list to hold all the tasks we want to insert
    List<Task> tasksToInsert = new List<Task>();

    // Loop through all opportunities in the trigger context
    for (Opportunity opp : Trigger.new) {
        
        // Use Trigger.oldMap to check for update-specific logic if needed
        // Check if StageName is 'Closed Won'
        if (opp.StageName == 'Closed Won') {
            
            // Create a new Task associated with this opportunity
            Task t = new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id // Associates the task with the opportunity
            );

            // Add it to the list for bulk insert
            tasksToInsert.add(t);
        }
    }

    // Bulk insert all tasks at once (outside the loop!)
    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}