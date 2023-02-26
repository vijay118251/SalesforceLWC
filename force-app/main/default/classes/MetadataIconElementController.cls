public with sharing class MetadataIconElementController {
    /*Set Class Name*/
    @TestVisible
    private static final String CLASS_NAME='MetadataIconElementController';
    
    @TestVisible
    public class MetadataIconWrapper {
        /*member details*/
        @AuraEnabled
        public List<MetadataIcon__mdt> details { get; set; }
        /* request */
        @AuraEnabled
        public Request command { get; set; }
        /* Constructor */
        @TestVisible
        private MetadataIconWrapper() {
        }
    }
    
    /* request wrapper used inside main wrapper*/
    @TestVisible
    private class Request {
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
    
    /*
* <Name>selectIconByPage</Name>
* <Summary>get icons from icon tray for selected page</Summary>
* <Parameter>Icon tray name</Parameter>
*/
    @AuraEnabled
    public static MetadataIconWrapper selectIconByPage(String pageName) {
        system.debug('pageName'+pageName);
        final MetadataIconWrapper iconWrapper = new MetadataIconWrapper();
        try {
            /* check metadata is accessible */
            isMetadataAcc('MetadataIcon__mdt');
            final MetadataIconSelector iconSelector = new MetadataIconSelector();
            final List<MetadataIcon__mdt> metagroupIcons = iconSelector.selectIconByPage(pageName);
            system.debug('metagroupIcons-->'+metagroupIcons);
            iconWrapper.details = metagroupIcons; 
            system.debug('iconWrapper.details--->'+iconWrapper.details);
            /*set request wrapper class*/
            final Request requestCall = new Request();
            requestCall.method = 'selectIconByPage';
            requestCall.identifier = new Map<String, String>{ 'pageName' => pageName };
            requestCall.responseTime = System.now();
            iconWrapper.command = requestCall;
            system.debug('iconWrapper.command--->'+iconWrapper.command);
        } catch(NoDataFoundException e){
            system.debug(e);
        }
        return iconWrapper;
    }
    
    
    /*
* <Name>isMetadataAcc</Name>
* <Summary>Return if metadata is accessible or not</Summary>
* <Parameter> fromString </Parameter>
*/
    private static Boolean isMetadataAcc(String fromString) {
        Boolean isMetadataAcc;
        final Schema.SObjectType schemaObj = Schema.getGlobalDescribe().get(fromString);
        if (schemaObj != null && schemaObj.getDescribe().isAccessible()) {
            isMetadataAcc = true;
        } else {
            //exception
            final NoDataFoundException excep = new NoDataFoundException();
            excep.setMessage('No Metadata Access.');
            throw excep;
        }
        //result
        return isMetadataAcc;
    }
}