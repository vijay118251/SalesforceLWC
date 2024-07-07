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
    
    // update phone field
    public static void updateWebsite(String webName) {
        List<Account> accList = [SELECT Id, Name, Type, Phone, Website,(SELECT Id, Name,Phone__c,Type__c,Customer__c,accountWebsite__c
                                          FROM vehicleInterests__r) 
                                 FROM Account WHERE Name='Vehicle Account1'];
        List<vehicleInterest__c> vhList = new List<vehicleInterest__c>();
        system.debug('ACC'+accList);
        for(Account acc:accList) {
            for(vehicleInterest__c vhRec:acc.vehicleInterests__r) {
                acc.Website=webName;
                vhRec.accountWebsite__c= acc.Website;
                vhList.add(vhRec);
                system.debug('VH'+vhRec);
            }
        }
        update accList;
        update vhList;
    }
    
}