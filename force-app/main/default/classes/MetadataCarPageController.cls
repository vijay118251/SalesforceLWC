public with sharing class MetadataCarPageController {

    private final static String CLASS_NAME = 'MetadataCarPageController';

    /*Metadata Car Wrapper*/
    public class MetadataWrapper {
        @AuraEnabled
        public Map<String,BmwCarModel__mdt> carDetails {get; set;}

        @AuraEnabled
        public Request command {get; set;}
    }

    /*Request Wrapper*/
    private class Request {
        @AuraEnabled
        public string method;

        @AuraEnabled
        public Map<String, String> identitfier;

        @AuraEnabled
        public Datetime responseTime;

    }


    @AuraEnabled
    public static MetadataWrapper selectCarPage(String pageName) {
        final MetadataWrapper wrap = new MetadataWrapper();

        try {
            final MetadataCarPageSelector carPageSelector = new MetadataCarPageSelector();
            if(String.isNotBlank(pageName) && isMetadataAcess('BmwCarModel__mdt')) {
                final Map<String,BmwCarModel__mdt> metaCarModels = carPageSelector.selectCarPage(pageName);
                wrap.carDetails=metaCarModels;
                // set request wrapper
                final Request req  = new Request();
                req.method='selectCarPage';
                req.identitfier= new Map<String, String> {'pageName' => pageName };
                req.responseTime= System.now();
                wrap.command = req;
            }

        }
        catch(AuraHandledException e) {
            throw new AuraHandledException(e.getMessage());
        }
        System.debug('Wrapper Reponse-->'+wrap);
        return wrap;
    }

    private static Boolean isMetadataAcess(String metaName) {
        final Schema.SobjectType schemaObj = Schema.getGlobalDescribe().get(metaName);
        if(schemaObj!=null && schemaObj.getDescribe().isAccessible()) {
            return true;
        } else {
            final NoDataFoundException excep = new NoDataFoundException();
            excep.setMessage('No MetaData Access');
            throw excep;
        }
    }


}