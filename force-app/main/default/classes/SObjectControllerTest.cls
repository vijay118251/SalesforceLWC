@isTest
public with sharing class SObjectControllerTest {

    @isTest
    static void testConstructor() {
        // Call the constructor
        SObjectController myInstance = new SObjectController();
    }

    //test data creation
    @testSetup
    public static void setup(){
        // Create a new user record
         User oldUser = new User(
            FirstName = 'John',
            LastName = 'Doe',
            Username = 'sonu@example.com.org',
            Email = 'johndoe@example.com',
            Alias = 'jdoe',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = UserInfo.getProfileId(), // Insert the Profile Id of the desired profile
            LanguageLocaleKey = 'en_US'
        );
        // Insert the user record
        insert oldUser;
        Account acc= new Account( Name='Infosys Limited', Type='Customer - Channel', Phone='8778975002',
                                 Rating='Hot', AnnualRevenue=95000000000.00, Active__c='Yes',OwnerId = oldUser.Id);
        insert acc;
        // Create a new user record
         User newUser = new User(
            FirstName = 'Mark',
            LastName = 'Antony',
            Username = 'mark@antony.com.org',
            Email = 'mark@antony.com',
            Alias = 'mAnt',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = UserInfo.getProfileId(), // Insert the Profile Id of the desired profile
            LanguageLocaleKey = 'en_US'
        );
        // Insert the user record
        insert newUser;
    }

    @isTest 
    public static void SObjectMethod() {
        List<string> fields = new List<string>{'Name', 'Type', 'Phone', 'Rating', 'AnnualRevenue', 'Active__c'};
		Test.startTest();
            List<SObject> lstAccount = SObjectController.retriveSObjectDetails('Account',fields);
        	system.debug('Accounts-->'+lstAccount);
            system.assertEquals(1,lstAccount.size(),'Found Records');

		Test.stopTest();
	}

    @isTest
    public static void userMethod() {
        User newUserRec = [SELECT Id FROM User WHERE FirstName = 'John' AND LastName = 'Doe' LIMIT 1];
        Test.startTest();
        List<String> fields = new List<String>{'Id', 'FirstName','LastName'};
        List<SObject> retrivedUser = SObjectController.retriveUserRecords('Account',fields,newUserRec.Id);
        system.debug('Users-->'+retrivedUser);
        Test.stopTest();
        // Assert that the user record was inserted successfully
        system.assertEquals(1,retrivedUser.size(),'Found Records');
    }
    
    @isTest
    public static void recCountMethod() {
        User userRec = [SELECT Id FROM User WHERE FirstName = 'John' AND LastName = 'Doe' LIMIT 1];
        User newUserRec = [SELECT Id FROM User WHERE FirstName = 'Mark' AND LastName = 'Antony' LIMIT 1];
        Test.startTest();
        Id batchId = SObjectController.invokeBatch('Account',userRec.Id,newUserRec.Id);
        Test.stopTest();
        List<Account> retrivedAccRec = [SELECT Id,Name,Type,Phone FROM Account WHERE OwnerId =:newUserRec.Id];
        // Assert that the user record was inserted successfully
        system.assertEquals(1,retrivedAccRec.size(),'Found Records');
    }
    
    // Test method for scenario when ObjectApiName or fields are not provided
    @isTest
    static void testRetrieveSObjectDetailsWithInvalidInput() {
        // Call the method without providing ObjectApiName and fields
        Test.startTest();
        List<SObject> result = SObjectController.retriveSObjectDetails(null, new List<String>());
        List<SObject> resultSobj = SObjectController.retriveUserRecords(null, new List<String>(),'');
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, result.size(), 'No records should be retrieved when ObjectApiName or fields are not provided');
         System.assertEquals(0, resultSobj.size(), 'No records should be retrieved when ObjectApiName or fields are not provided');
    }
    
    // Test method for scenario when an exception occurs
    @isTest
    static void testRetrieveSObjectDetailsWithException() {
        // Call the method with an invalid ObjectApiName
        Test.startTest();
        try {
            List<SObject> result = SObjectController.retriveSObjectDetails('InvalidObject', new List<String>{'Name'});
            // The method should throw an exception and not reach this point
            System.assert(false, 'Exception should have been thrown');
        } catch(AuraHandledException e) {
            // Expected exception, no need for further action
        }
        Test.stopTest();
    }
}