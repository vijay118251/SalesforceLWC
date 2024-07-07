public with sharing class VehicleMapController {

    /*Class Name*/
    @TestVisible
    Private Static final String CLASS_NAME='VehicleMapController';

    //wrapper class
    public Class VehicleWrapper {
        /*vehicle details*/
        @AuraEnabled
        public Map<Id, vehicleInterest__c> details {get;set;}
    }
    
    @AuraEnabled
    public static  VehicleWrapper mapMethod(String accId) {
        final VehicleWrapper wrap = new VehicleWrapper();
        try {
            if(accId!=null && isVehicleAccess()) {
                final VehicleSelector selector = new VehicleSelector();
                selector.setEnforceSecurity(true);
                selector.setStripInaccessible(false);
                List<vehicleInterest__c> vhcList = selector.dynamicQuery(new Set<Id>{accId});
                if(!vhcList.isEmpty()) {
                    Map<Id, vehicleInterest__c> mapName = new Map<Id, vehicleInterest__c>(vhcList);
                    wrap.details=mapName;                
                }
            }

        }
        catch(NoDataFoundException e){
            system.debug(e);
        }
        system.debug('wrap'+wrap);
        return wrap;

    }

    // check object access
    public static Boolean isVehicleAccess() {
        Boolean objAccess;
        if(Schema.sObjectType.vehicleInterest__c.isAccessible()) {
            objAccess = true;
        }
        else {
            //exception
            final NoDataFoundException excep = new NoDataFoundException();
            excep.setMessage('No Metadata Access.');
            throw excep;
        }
        return objAccess;
    }

}