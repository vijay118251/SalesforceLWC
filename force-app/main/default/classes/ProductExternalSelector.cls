public class ProductExternalSelector {
    /*Connection Service*/
    private static final ConnectionServices service = new ConnectionServices('apidetails','GET','points');
    /*Enforce Security*/
    private Boolean enforceSecurity = false;

    /*
     * <Name>setEnforceSecurity</Name>
     */
    public ProductExternalSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }

     /* ResultWrapper class */
    public class ResultWrapper {    
        /* Result Details */
        @AuraEnabled
        public List<ProductDetails> result { get; set; }
    }

    public ResultWrapper getProductDetails(String product){
        ResultWrapper result = new ResultWrapper();
        result = callout(product);
        return result;
    }

    public ResultWrapper callout(String product) {
        final ResultWrapper resultWrapper = new ResultWrapper();
        final String endpoint = 'callout:ProductCallout/'+product;
        System.debug('Endpoint-->'+endpoint);
        final String respText = service.get(endpoint);
        System.debug('respText-->'+respText);
        if(String.isNotBlank(respText)){
        resultWrapper.result = ProductDetails.parse(respText);
        }
        System.debug('Parser-->'+resultWrapper.result);
        return resultWrapper;

    }

}