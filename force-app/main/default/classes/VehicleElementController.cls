public with sharing class VehicleElementController {
    
    /*Class Name*/
    @TestVisible
    Private Static final String CLASS_NAME='VehicleElementController';
    
    @TestVisible
    public class VehicleWrapper {
        /*vehicle details*/
        @AuraEnabled
        public List<vehicleInterest__c> details {get;set;}
        /* request */
        public Request command {get;set;}
        /* constructor */
        public VehicleWrapper() {   
        }
    }
    
    @TestVisible
    public class Request {
        /* method name*/
        @AuraEnabled
        public String method { get; set; }
        /*identifier*/
        @AuraEnabled
        public Map<String, String> identifier { get; set; }
        /* responseTime*/
        @AuraEnabled
        public Datetime responseTime { get; set; }
        
        /* Constructor */
        @TestVisible
        private Request() {
        }
    }
    
    /* constructor */
    public VehicleElementController() {
        
    }
    
    /*
* <Name>queryVehicleRecords</Name>
* <Summary>Query Vehicle Interest Records</Summary>
* <Parameter>Icon tray name</Parameter>
*/
    @AuraEnabled
    public static VehicleWrapper queryVehicleRecords(String accId){
        final VehicleWrapper vhWrap = new VehicleWrapper();
        /* check vehicleInterest is accessible */
        if(accId!=null && hasUserGotObjectAccess('vehicleInterest__c')){
            system.debug('inside if');
            try {
                final VehicleSelector selector = new VehicleSelector();
                selector.setEnforceSecurity(true);
                selector.setStripInaccessible(false);
                selector.setOrderBy('LastModifiedDate DESC');
                List<vehicleInterest__c> vhcList = selector.dynamicQuery(new Set<Id>{accId});
                if(!vhcList.isEmpty()) {
                    vhWrap.details=vhcList;                
                }
                final Request requestCall = new Request();
                requestCall.method = 'queryVehicleRecords';
                requestCall.identifier = new Map<String, String>{ 'accId' => accId };
                    requestCall.responseTime = System.now();
                vhWrap.command = requestCall;
            }
            catch(NoDataFoundException e){
                system.debug(e);
            }
            
        }
        system.debug('vhWrap-->'+vhWrap);
        return vhWrap;
    }
    
    /*
* <Name>hasUserGotObjectAccess</Name>
* <Summary>Return if vehicle object is accessible or not</Summary>
* <Parameter> fromString </Parameter>
*/
    
    public static Boolean hasUserGotObjectAccess(String obj){
        Boolean objAccess;
        final Schema.SObjectType schemaObj = Schema.getGlobalDescribe().get(obj);
        if (schemaObj != null && schemaObj.getDescribe().isAccessible()) {
            objAccess = true;
        } else {
            //exception
            final NoDataFoundException excep = new NoDataFoundException();
            excep.setMessage('No Object Access.');
            throw excep;
        }
        system.debug('objAccess-->'+objAccess);
        return objAccess;
    }
    
}