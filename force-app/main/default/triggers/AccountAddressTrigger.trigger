trigger AccountAddressTrigger on Account (before insert, before update) {

    // Loop through each Account record in the trigger context
    // Trigger.new gives you access to the records being inserted/updated
    for (Account acc : Trigger.new) {

        // Check if the custom checkbox field 'Match_Billing_Address__c' is true
        // This indicates the user wants to copy the billing postal code to the shipping postal code
        if (acc.Match_Billing_Address__c == true) {

            // Optional: Make sure the billing postal code is not null
            // Prevents overwriting shipping postal code with null if billing info is incomplete
            if (acc.BillingPostalCode != null) {

                // Set the shipping postal code to match the billing postal code
                // This works because it's a "before" trigger — changes to 'acc' will be saved automatically
                acc.ShippingPostalCode = acc.BillingPostalCode;

            }
        }
    }
}