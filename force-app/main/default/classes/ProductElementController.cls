public with sharing class ProductElementController {

    /*set class name*/
    public final static String CLASS_Name='ProductElementController';
    /*set ERROR_CODE to 404*/
    private static final String ERROR_CODE ='404';

    @TestVisible
    public Class ProductWrapper {
        @AuraEnabled
        /* ProductDetails */
        public List<ProductDetails> details { get;set; }
        @AuraEnabled
        public Request command { get;set; }
         /* error */
        @AuraEnabled
        public ErrorDetails error { get; set; }
         /* Constructor*/
        @TestVisible
        private ProductWrapper() {
        }
    }

    @TestVisible
    private class Request {
        /* method name*/
        @AuraEnabled
        public string method { get;set; }
        /*identifier*/
        @AuraEnabled
        public Map<String, String> identifier { get;set; }
        /* responseTime*/
        @AuraEnabled
        public Datetime responseTime { get;set; }

        /* Constructor*/
        @TestVisible
        private Request() {
        }
    }

    /*
     * <Name>getObjects</Name>
     * <Summary>get object Details</Summary>
     * <Parameter>Object</Parameter>
     */
    @AuraEnabled
    public static ProductWrapper getProductDetails(String product) {
        final ProductWrapper wrapper = new ProductWrapper();
        try{
            if(String.isNotBlank(product)){
                final ProductExternalSelector selector = new ProductExternalSelector();
                ProductExternalSelector.ResultWrapper resultWrap = selector.getProductDetails(product);
                System.debug('Wrap Reponse-->'+resultWrap);
                if(resultWrap.result!=null) {
                    wrapper.details = resultWrap.result;
                }
                /*set wrapper request*/
                final Request command = new Request();
                command.method = 'getProductDetails';
                command.identifier = new Map<String, String>{ 'product' => product };
                command.responseTime = System.now();
                wrapper.command = command;
            }

        } catch(AuraHandledException e) {
            throw new AuraHandledException(e.getMessage());
        }
        System.debug('Final Reponse-->'+wrapper);
        return wrapper;

    }
}