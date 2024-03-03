public with sharing class EmployeeDetailsController {
     /*set class name*/
    private static final String CLASS_NAME = 'EmployeeDetailsController';
     /*set ERROR_CODE to 404*/
    private static final String ERROR_CODE ='404';

    @TestVisible
    public class EmployeeWrapper {
         /*Vitality Details*/
        @AuraEnabled
        public EmployeeDetails details { get; set; }
        /* request */
        @AuraEnabled
        public Request command { get;set; }
         /* error */
        @AuraEnabled
        public ErrorDetails error { get; set; }
         /* Constructor*/
        @TestVisible
        private EmployeeWrapper() {
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

    private EmployeeDetailsController() {
    }

    @AuraEnabled
    public static EmployeeWrapper getEmployeeData(String empId) {
        final EmployeeWrapper wrapper = new EmployeeWrapper();
        try {
            if(!String.isBlank(empId)) {
                final EmployeeSelector selector = new EmployeeSelector();
                selector.setEnforceSecurity(true);
                EmployeeSelector.ResultWrapper resultWrap = selector.getEmployeeData(new Set<String> {empId});
                if(resultWrap.result!=null) {
                    wrapper.details = resultWrap.result;
                }

        } else {
            final EmployeeSelector selector = new EmployeeSelector();
                selector.setEnforceSecurity(true);
                EmployeeSelector.ResultWrapper resultWrap = selector.getEmployeesData();
                if(resultWrap.result!=null) {
                    wrapper.details = resultWrap.result;
                }
        }
        /*set wrapper request*/
        final Request command = new Request();
        command.method = 'getEmployeeData';
        command.identifier = new Map<String, String>{ 'empId' => empId };
        command.responseTime = System.now();
        wrapper.command = command;
    }
    catch(AuraHandledException e) {
        throw new AuraHandledException(e.getMessage());
    }
    system.debug('RESPONSE-->'+wrapper);
    return wrapper;
}
}