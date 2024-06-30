public with sharing class EmployeeSelector {
    /*Connection Service*/
    private static final ConnectionService service = new ConnectionService('Employee_Details','');
    /*Enforce Security*/
    private Boolean enforceSecurity = false;

    /*
     * <Name>setEnforceSecurity</Name>
     */
    public EmployeeSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }

    /* ResultWrapper class */
    public class ResultWrapper {
        
        /* Result Details */
        @AuraEnabled
        public EmployeeDetails result { get; set; }
        @AuraEnabled
        public string errorMessage { get;set; }

        @TestVisible
        public ResultWrapper(){
        }
    }

    /*
     * <Name>selectFromAccId</Name>
     * <Summary>get EmployeeDetails </Summary>
     * <Parameter>Account Id</Parameter>
    */

    public ResultWrapper getEmployeeData(Set<String> empId) {
        ResultWrapper resultWrapper = new ResultWrapper();
        resultWrapper = Callout(empId);
        return resultWrapper;

    }

    public ResultWrapper getEmployeesData() {
        ResultWrapper resultWrapper = new ResultWrapper();
        resultWrapper = empCallout();
        return resultWrapper;

    }

    private ResultWrapper Callout(Set<String> empId) {
        final ResultWrapper resultWrapper = new ResultWrapper();
        final String endpoint = new List<String>(empId).get(0);
        final String respText = service.get(endpoint);
        if (respText != null) {
            if (respText.contains('errorMessage')) {
                resultWrapper.errorMessage = respText;
        } else {
                resultWrapper.result = EmployeeDetails.parse(respText);
            }
        }
        return resultWrapper;
    }

    private ResultWrapper empCallout() {
        final ResultWrapper resultWrapper = new ResultWrapper();
        final String respText = service.get('');
        if (respText != null) {
            if (respText.contains('errorMessage')) {
                resultWrapper.errorMessage = respText;
        } else {
                resultWrapper.result = EmployeeDetails.parse(respText);
            }
        }
        return resultWrapper;
    }


    public EmployeeSelector() {

    }
}