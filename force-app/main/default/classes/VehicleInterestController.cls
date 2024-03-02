// Insert Vehicle Records
public class VehicleInterestController {
    
    // insertVehicleRecords Method
    public static void insertVehicleRecords(String active, Decimal annualRevenue) {
        
        List<Account> accList = [SELECT Id, Name, Type, Phone, Rating, AnnualRevenue, Active__c 
                                 FROM Account WHERE Active__c=:active AND AnnualRevenue>=:annualRevenue];
        system.debug('accList-->'+accList);
        List<vehicleInterest__c> vhList = new List<vehicleInterest__c>();
        if(!accList.isEmpty()) {
            for(Account acc:accList) {
                vehicleInterest__c vhRec = new vehicleInterest__c();
                vhRec.Name = 'BMW X4';
                vhRec.Type__c='SUV';
                vhRec.X4_Wheel_Drive__c=true;
                vhRec.Exterior_Color__c='Black,White';
                vhRec.Customer__c= acc.Name;
                vhRec.Sunroof__c=true;
                vhRec.Email__c='james@yahhoo.com';
                vhRec.Account__c=acc.Id;
                vhList.add(vhRec);
                system.debug('vhList-->'+vhList);
            }
        }
        
        // insert records
        insert vhList;
    }
    
    // insertAccountRec Method
    public static void insertAccountRec(Integer num) {
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=num;i++) {
            Account acc = new Account(Name='Vehicle Account'+i,Type='Customer - Channel',Industry='Construction',AccountNumber='UK');
            accList.add(acc);
        }
        if(!accList.isEmpty()) {
            insert accList;
        } 
        system.debug('accList-->'+accList);
        insertAccVehicleRec(accList);
    }
    
     // insertAccVehicleRec Method
     public static void insertAccVehicleRec(List<Account> accLists) {
         List<vehicleInterest__c> vhList = new List<vehicleInterest__c>();
         for(Account acc:accLists) {
             system.debug('lenght'+acc.AccountNumber.length());
             for(Integer i=1; i<=acc.AccountNumber.length();i++) {
                 vehicleInterest__c vhRec = new vehicleInterest__c();
                 vhRec.Name = 'Sonu Alto'+i;
                 vhRec.Type__c='SUV';
                 vhRec.X4_Wheel_Drive__c=true;
                 vhRec.Exterior_Color__c='Black';
                 vhRec.Customer__c= acc.Name;
                 vhRec.Sunroof__c=true;
                 vhRec.Email__c='sonu@dpvj.com';
                 vhRec.Account__c=acc.Id;
                 vhList.add(vhRec);
                 system.debug('vhList-->'+vhList);
             }
         }
         // insert records
        	insert vhList;
     }
}