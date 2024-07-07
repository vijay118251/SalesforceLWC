@isTest
public class TestShippingToBillingAddressTest {
    @testSetup
    static void setup(){
        Account acc = new Account();
        acc.Name = 'Testing from class';
        acc.ShippingStreet = 'White Field';
        acc.ShippingCity = 'Bangalore';
        acc.ShippingCountry = 'India';
        acc.ShippingPostalCode = '464654';
        acc.ShippingState ='Karnataka';
        insert acc;
    }
 
    @isTest
    public static void TestAddress(){
        List<Account> accList = [SELECT BillingStreet,ShippingStreet,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState FROM Account WHERE Name = 'Testing from class'];
        Test.startTest();
        Address.ShippingToBillingAddress(accList);
        Test.stopTest();   
        system.assertEquals(accList[0].ShippingStreet, accList[0].BillingStreet);
    }
    
    @isTest
    public static void UpdateTestAddress(){
        List<Account> accList = [SELECT BillingStreet,ShippingStreet,ShippingCity,ShippingCountry,
                                 ShippingPostalCode,ShippingState FROM Account WHERE Name = 'Testing from class'];
        List<Account> updatedList = new List<Account>();
        for(Account acc:accList) {
            acc.ShippingStreet='MR Street';
            updatedList.add(acc);
        }
        update updatedList;
        Test.startTest();
        Address.ShippingToBillingAddress(updatedList);
        Test.stopTest();
        system.assertEquals(updatedList[0].ShippingStreet, updatedList[0].BillingStreet);
    }
    
    @isTest
    public static void testHelloWorldTrigger() {
        List<Account> accList = [SELECT Hello__c FROM Account WHERE Name = 'Testing from class'];
        Test.startTest(); 
        Address.HelloWorld(accList);                       
        Test.stopTest();
        System.assertEquals('World', accList[0].Hello__c);
    }
}