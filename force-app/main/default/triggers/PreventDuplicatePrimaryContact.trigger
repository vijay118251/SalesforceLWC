trigger PreventDuplicatePrimaryContact on Contact (before insert, before update) {
    
    // Map to store Account Ids and whether they have a primary contact
    Map<Id, Boolean> accountHasPrimaryContactMap = new Map<Id, Boolean>();
    //Store the Account Ids
    Set<Id> accountId = new Set<Id>();
    List<Id> accId = new List<Id>();
    if(Trigger.isInsert && Trigger.isBefore) {
        
        // Iterate through the new Contacts
        for (Contact newContact : Trigger.new) {
            accountId.add(newContact.AccountId);
        }
        // Query to find existing Primary Contacts for the same Accounts
        List<Contact> existingPrimaryContacts = [SELECT Id, AccountId FROM Contact WHERE Primary_Contact__c = true AND AccountId IN :accountId];
        // Loop through existing Primary Contacts and mark their Account as having a Primary Contact
        for (Contact existingContact : existingPrimaryContacts) {
            accountHasPrimaryContactMap.put(existingContact.AccountId, true);
        }
        // Iterate through the new Contacts
        for (Contact newContact : Trigger.new) {
            if (newContact.Primary_Contact__c) {
                // If the new Contact has Primary Contact checked
                if (accountHasPrimaryContactMap.containsKey(newContact.AccountId) && accountHasPrimaryContactMap.get(newContact.AccountId)) {
                    // If there's already a Primary Contact for the same Account, throw an error
                    newContact.addError('An Account can have only one Primary Contact.');
                } else {
                    // Mark the Account as having a Primary Contact
                    accountHasPrimaryContactMap.put(newContact.AccountId, true);
                    accId.add(newContact.AccountId);
                    FutureApexCallout.callout(accId);
                }
            }
        }
    }
    
    if(Trigger.isUpdate && Trigger.isBefore) {
        // Check the Account status and throw an error for Contacts if their Account already has a Primary Contact
        for (Contact newContact : Trigger.new) {
            if (newContact.Primary_Contact__c!=Trigger.oldMap.get(newContact.Id).Primary_Contact__c) {
                newContact.addError('Primary Contact Cannot be Changed.');
            }
        }
        
    }
}