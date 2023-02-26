/* @author: Vijay M
Test Class for VehicleInterestMap
*/
@isTest
public class VehicleInterestMapTest {
    
    //test data creation
    @testSetup
    public static void setup(){
        Account acc= new Account( Name='Test Phone', Type='Customer - Channel', Phone='8778975002', Rating='Hot', AnnualRevenue=985000.00, Active__c='Yes');
        insert acc;
        vehicleInterest__c vh = new vehicleInterest__c(Name='BMW X1',Email__c='vvj5413@gmail.com',Customer__c='Vijay LTD',
                                                       Exterior_Color__c='Red',X4_Wheel_Drive__c=true,Type__c='SUV',Sunroof__c=true,Account__c=acc.Id);
        insert vh;
    }
    
    //method
    @isTest
    public static void method(){
        Test.startTest();
        VehicleInterestMap.vehicleMapMethod();
        Test.stopTest();
        Account accRec=[SELECT Id,Phone,Name From Account];
        vehicleInterest__c vhREc =[SELECT Id, Name,Phone__c,Type__c,Customer__c,Account__r.Name,Account__r.Phone
                                          FROM vehicleInterest__c WHERE Account__c=:accRec.Id];
        system.assertEquals('BMW X1', vhREc.Name);
    }

}