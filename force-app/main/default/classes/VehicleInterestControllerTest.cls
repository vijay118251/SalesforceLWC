// Test class for VehicleInterestController
@isTest
public class VehicleInterestControllerTest {
    
    //test data creation
    @testSetup
    public static void setup(){
        Account acc= new Account( Name='Car Test', Type='Customer - Channel', Phone='8778975002', Rating='Hot', AnnualRevenue=95000000000.00, Active__c='Yes');
        insert acc;
    }
    
    //method
    @isTest
    public static void method(){
        Test.startTest();
        Account accRec = [SELECT Id, Name, Type, Phone, Rating, AnnualRevenue, Active__c 
                                 FROM Account];
        system.debug('accRec-->'+accRec);
        VehicleInterestController.insertVehicleRecords(accRec.Active__c,accRec.AnnualRevenue);
        Test.stopTest();
        Integer vhCount = [SELECT Count() FROM vehicleInterest__c WHERE Account__r.Name='Car Test'];
        system.debug('vhCount-->'+vhCount);
        system.assertEquals(1,vhCount,'Found Records');
    }
}