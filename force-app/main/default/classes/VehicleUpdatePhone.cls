// Update Phone field of Vehicle Records
// from assocaited account
public class VehicleUpdatePhone {
    
    // update phone field
    public static void updatePhone() {
        List<vehicleInterest__c> vhList =[SELECT Id, Name,Phone__c,Type__c,Customer__c,Account__r.Name,Account__r.Phone
                                          FROM vehicleInterest__c WHERE Account__c!=null AND CreatedDate=Today];
        system.debug('vhList-->'+vhList);
        for(vehicleInterest__c vh:vhList) {
            if(vh.Phone__c==null) {
                vh.Phone__c=vh.Account__r.Phone;
            }         
        }
        // update vehicle reocrds
        if(!vhList.isEmpty()) {
            update vhList;
        }
        system.debug('vhList-->'+vhList);
    }
    
}