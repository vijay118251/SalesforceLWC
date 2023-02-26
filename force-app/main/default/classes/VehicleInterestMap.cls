// VehicleInterestMap
public with sharing class VehicleInterestMap {
    
    PRIVATE FINAL static String CLASS_NAME='VehicleInterestMap';
    //vehicleMapMethod
    public static void vehicleMapMethod() {
        List<vehicleInterest__c> vhList =[SELECT Id, Name, Type__c, X4_Wheel_Drive__c, Exterior_Color__c,
                                          Customer__c, Sunroof__c, Email__c, Account__c FROM vehicleInterest__c 
                                          WHERE Account__c!=null WITH SECURITY_ENFORCED];
        
        Map<Id,vehicleInterest__c> vhMap = new Map<Id,vehicleInterest__c>(vhList);
        system.debug('vhMap-->'+vhMap);
        List<vehicleInterest__c> newList = new List<vehicleInterest__c>();
        Set<Id> vhSet = new Set<Id>();
        
        // Add vehicle Id to set
        for(Id vhId:vhMap.keySet()) {
            vhSet.add(vhId);
            system.debug('vhSet-->'+vhSet);
            system.debug('get records-->'+vhMap.get(vhId));
        }
        
        // Add vehicle records to new lst from map
        if(!vhMap.isEmpty() && isvehicleInterest()) {
            for(vehicleInterest__c vhRec:vhMap.values()) {
                newList.add(vhRec);
            }
        }
        
    }
    
    public static Boolean isvehicleInterest() {
        Boolean userHasAccess;
        try {
            if(Schema.SObjectType.vehicleInterest__c.isAccessible()) {
                userHasAccess=true;
            } 
        }
        catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage()); 
        }
        system.debug('userHasAccess-->'+userHasAccess);
        return userHasAccess;
    }
}