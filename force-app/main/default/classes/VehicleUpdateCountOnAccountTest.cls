/* @author: Vijay M
  Test Class for VehicleUpdateCountOnAccount
*/
@isTest
public class VehicleUpdateCountOnAccountTest {
    
    //test data creation
    @testSetup
    public static void setup(){
        Account acc= new Account( Name='Test Count', Type='Customer - Channel', Phone='8778975002', Rating='Hot', AnnualRevenue=985000.00, Active__c='Yes');
        insert acc;
        vehicleInterest__c vh = new vehicleInterest__c(Name='BMW X1',Email__c='vvj5413@gmail.com',Customer__c='Vijay LTD',Phone__c ='8778975002',
                                                            Exterior_Color__c='Red',X4_Wheel_Drive__c=true,Type__c='SUV',Sunroof__c=true,Account__c=acc.Id);
        insert vh;
    }
    
    //method
    @isTest
    public static void method(){
        Test.startTest();
        Account accRec = [SELECT Id, Name, Type, Phone, Rating, AnnualRevenue, Active__c 
                                 FROM Account];
        system.debug('accRec-->'+accRec);
        UpdateCountOnAccount.updateVehicleCount(accRec.Active__c,accRec.AnnualRevenue);
        Test.stopTest();
        Integer VehicleCount =[SELECT COUNT() FROM vehicleInterest__c WHERE Account__c=:accRec.Id];
        system.assertEquals(1, VehicleCount);
    }

}