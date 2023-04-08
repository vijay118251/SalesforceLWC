/*
 * <Author>Vijay</Author>\
 **/
public class PointsElementController {

    /*set class name*/
    private static final String CLASS_NAME = 'PointsElementController';
     /*set ERROR_CODE to 404*/
    private static final String ERROR_CODE ='404';

    @TestVisible
    public class PointsWrapper {
         /*Vitality Details*/
        @AuraEnabled
        public List<PointsDetails> details { get; set; }
        /* request */
        @AuraEnabled
        public Request command { get;set; }
         /* error */
        @AuraEnabled
        public ErrorDetails error { get; set; }
         /* Constructor*/
        @TestVisible
        private PointsWrapper() {
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
     * <Name>selectFromAccId</Name>
     * <Summary>get Details</Summary>
     * <Parameter>Account Id</Parameter>
     */
    @AuraEnabled
    public static PointsWrapper selectFromAccId(String accId) {
        final PointsWrapper wrapper = new PointsWrapper();
        try {
            if(objectAccess() && isNotNull(accId)) {
                final PointsExternalSelector selector = new PointsExternalSelector();
                selector.setEnforceSecurity(true);
                PointsExternalSelector.ResultWrapper resultWrap = selector.selectFromAccId(new Set<ID> {accId});
                if(resultWrap.result!=null) {
                    wrapper.details = resultWrap.result;
                }
                /*set wrapper request*/
                final Request command = new Request();
                command.method = 'selectFromAccId';
                command.identifier = new Map<String, String>{ 'accId' => accId };
                command.responseTime = System.now();
                wrapper.command = command;
            }

        }
        catch(AuraHandledException e) {
            throw new AuraHandledException(e.getMessage());
        }
        system.debug('RESPONSE-->'+wrapper);
        return wrapper;
    }

     /*
     * <Name>objectAccess</Name>
     * <Summary>validate object accessible</Summary>
     */
    public static Boolean objectAccess() {
        if(Schema.sObjectType.Account.isAccessible()) {
            return true;
        } else {
            throw new NoAccessException();
        }
    }

     /*
     * <Name>objectAccess</Name>
     * <Summary>validate object accessible</Summary>
     */
    public static Boolean isNotNull(String accId) {
        Boolean isNotNull;
        if(accId!=null) {
            isNotNull = true;
        } else {
             //exception
            final NullPointerException excep = new NullPointerException();
            excep.setMessage('Account Id value is null.');
            throw excep;
        }
        return isNotNull;
    }


}