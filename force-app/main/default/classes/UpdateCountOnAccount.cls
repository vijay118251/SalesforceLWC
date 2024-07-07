// Update Vehicle Count on Account Records
public class UpdateCountOnAccount {
    
    // updateVehicleCount method
    public static void updateVehicleCount(String active, Decimal annualRevenue) {
        system.debug('active-->'+active +','+ 'annualRevenue'+annualRevenue);
        List<Account> accList = [SELECT Id,Name,vehicleCount__c, 
                                 (SELECT Id, Name, Type__c,Customer__c,Account__c
                                  FROM vehicleInterests__r WHERE Account__c!=null) 
                                 FROM Account WHERE Active__c=:active AND AnnualRevenue=:annualRevenue];
        system.debug('accList-->'+accList);
            for(Account acc:accList) {
                Integer VehicleCount =[SELECT COUNT() FROM vehicleInterest__c WHERE Account__c=:acc.Id];
                system.debug('VehicleCount-->'+VehicleCount);
                acc.vehicleCount__c= acc.vehicleInterests__r.size();
            }
        // update vehicle count
        update accList;
        system.debug('accList-->'+accList);
    }
    
}