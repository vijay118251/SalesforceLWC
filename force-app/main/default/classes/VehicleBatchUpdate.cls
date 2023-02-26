/* @author  Vijay M
* <Purpose> To update VehicleInterests <Purpose> */
public class VehicleBatchUpdate implements Database.Batchable<sobject>,Database.stateful {
    
     Integer recordCount=0;
    //start method
    public Database.QueryLocator start(Database.BatchableContext bc) {
        /** query**/
        final String query = 'SELECT Id, Name, Type__c, X4_Wheel_Drive__c, Exterior_Color__c, Customer__c, Sunroof__c,'+
                             'carStatus__c, Email__c, Account__c, Phone__c FROM vehicleInterest__c';
        return Database.getQueryLocator(query);
    }
    
    //execute method
    public void execute(Database.BatchableContext bc, List<vehicleInterest__c> vhList) {
        final List<vehicleInterest__c> vhcRecs = new List<vehicleInterest__c>();
        for(vehicleInterest__c vh:vhList){
            if(vh.Name=='false') {
                vh.carStatus__c='Sold';
            } else {
                vh.carStatus__c='Available';
            }
            vhcRecs.add(vh);
            recordCount++;
            system.debug('recordCount-->'+recordCount);
        }
          // update VehicleInterests
        update vhcRecs;
    }
    
    //finish method
    public void finish(Database.BatchableContext bc) {
         // Logic to be Executed at finish
        system.debug('Batch job Completed');
    }

}