@isTest
public with sharing class BatchUpdatorServiceTest {
    
     //test data creation
    @testSetup
    public static void setup(){
        // Create a new user record
         User oldUser = new User(
            FirstName = 'John',
            LastName = 'Doe',
            Username = 'sonu@example2626.com.org',
            Email = 'johndoe@example.com',
            Alias = 'jdoe',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = '00e5g000001j1upAAA', // Insert the Profile Id of the desired profile
            LanguageLocaleKey = 'en_US'
        );
        // Insert the user record
        insert oldUser;
        Account acc= new Account( Name='Infosys Limited', Type='Customer - Channel', Phone='8778975002',
                                 Rating='Hot', AnnualRevenue=95000000000.00,OwnerId = oldUser.Id);
        insert acc;
        // Create a new user record
         User newUser = new User(
            FirstName = 'Mark',
            LastName = 'Antony',
            Username = 'mark@antony2626.com.org',
            Email = 'mark@antony.com',
            Alias = 'mAnt',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = '00e5g000001j1upAAA', // Insert the Profile Id of the desired profile
            LanguageLocaleKey = 'en_US'
        );
        // Insert the user record
        insert newUser;
    }
    
     @isTest
    public static void callBatchClass() {
    // Start the batch job
    	User userRec = [SELECT Id FROM User WHERE FirstName = 'John' AND LastName = 'Doe' LIMIT 1];
        User newUserRec = [SELECT Id FROM User WHERE FirstName = 'Mark' AND LastName = 'Antony' LIMIT 1];
        // Set the values for ObjectApiName, ownerID, and newOwnerID
        String objectApiName = 'Account'; // Object API name to be updated
        String ownerId = userRec.Id; // Original owner ID of records to be updated
        String newOwnerId = newUserRec.Id; // New owner ID to be set
        Test.startTest();
        BatchUpdatorService batchJob = new BatchUpdatorService(objectApiName,ownerId,newOwnerId);
        Database.executeBatch(batchJob);
        Test.stopTest();
        // Verify results
        Integer expectedSuccessCount = 1;
        Integer expectedFailureCount = 0;
        // Verify that all records were processed and updated
        List<Account> retrivedAccRec = [SELECT Id,Name,OwnerId,Type,Phone FROM Account WHERE OwnerId =:newUserRec.Id];
        Integer actualSuccessCount = 0;
        Integer actualFailureCount = 0;
        for(Account acc : retrivedAccRec) {
            if(acc.OwnerId == newUserRec.Id) {
                actualSuccessCount++;
            } else {
                actualFailureCount++;
            }
        }
        
        System.assertEquals(expectedSuccessCount, actualSuccessCount, 'Number of successfully updated records');
        System.assertEquals(expectedFailureCount, actualFailureCount, 'Number of failed updates');
        // Assert that the user record was inserted successfully
        system.assertEquals(1,retrivedAccRec.size(),'Found Records');
    }
}