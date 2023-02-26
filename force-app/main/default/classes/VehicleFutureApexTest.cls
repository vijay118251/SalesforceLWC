/* author:Vijay M
 * Test Class for VehicleFutureApex
*/
@isTest
public class VehicleFutureApexTest {
    
    @testSetup
    public static void setUp(){
        List<vehicleInterest__c> vhList = new List<vehicleInterest__c>();
        for(integer i=0;i<2;i++) {
            vehicleInterest__c vhRec= new vehicleInterest__c();
            vhRec.Name='Jaguar XF';
            vhRec.Email__c='vvj5413@gmail.com';
            vhRec.Customer__c='Vijay LTD';
            vhRec.Phone__c ='8778975002';
           	vhRec.Exterior_Color__c='Red';
            vhRec.X4_Wheel_Drive__c=true;
            vhRec.Type__c='SUV';
            if(i==0) {
                vhRec.Sunroof__c=true;
            } else{
                vhRec.Sunroof__c=false;
            }
            vhList.add(vhRec);
        }
        insert vhList;
    }
    
    @isTest
    public static void methodTrue(){
        Test.startTest();
        VehicleFutureApex.checkSunroof();
        Test.stopTest();
        List<vehicleInterest__c> vhList =[SELECT Id, Name, Exterior_Color__c, Type__c, X4_Wheel_Drive__c, 
                                  Customer__c, Sunroof__c, Email__c, Model__c FROM vehicleInterest__c WHERE Sunroof__c=true ];
        system.assertEquals('Automatic',vhList[0].Model__c);
    }
    
    @isTest
    public static void methodFalse(){
        Test.startTest();
        VehicleFutureApex.checkSunroof();
        Test.stopTest();
        List<vehicleInterest__c> vhList =[SELECT Id, Name, Exterior_Color__c, Type__c, X4_Wheel_Drive__c, 
                                  Customer__c, Sunroof__c, Email__c, Model__c FROM vehicleInterest__c WHERE Sunroof__c=false ];
        system.assertEquals('Manual',vhList[0].Model__c);
    }

}