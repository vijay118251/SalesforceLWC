/*
 * <Purpose> Get API Details </Purpose>
 */
public class PointsExternalSelector {
    /*Connection Service*/
    private static final ConnectionServices service = new ConnectionServices('apidetails','GET','points');
    /*Enforce Security*/
    private Boolean enforceSecurity = false;

    /*
     * <Name>setEnforceSecurity</Name>
     */
    public PointsExternalSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }

     /* ResultWrapper class */
     public class ResultWrapper {
        
        /* Result Details */
        @AuraEnabled
        public List<PointsDetails> result { get; set; }
        @TestVisible
        public ResultWrapper(){
        }
    }

    /*
     * <Name>selectFromAccId</Name>
     * <Summary>get PointsDetails </Summary>
     * <Parameter>Account Id</Parameter>
    */

    public ResultWrapper selectFromAccId(Set<ID> accId) {
        ResultWrapper resultWrapper = new ResultWrapper();
        resultWrapper = Callout(accId);
        return resultWrapper;

    }

    /*
     * <Name>Callout</Name>
    */
    private ResultWrapper Callout(Set<ID> accId) {
        final ResultWrapper resultWrapper = new ResultWrapper();
        final String endpoint = 'points';
        //final String respText = service.get(endpoint);
        String respText = '['+
        '{'+
        '\"vitalityPlanId\": \"5062741497\",'+
        '\"planType\": \"Wellness\",'+
        '\"planCode\": \"VITPLNQ\",'+
        '\"planStartDate\": \"2022-07-02\",'+
        '\"previousRenewalDate\": \"2022-07-14\",'+
        '\"renewalDate\": \"2023-07-14\",'+
        '\"family-members\": ['+
        '{'+
        '\"entityId\": \"1214514794\",'+
        '\"name\": {'+
        '\"title\": \"MR\",'+
        '\"forename\": \"JOSHUA\",'+
        '\"surname\": \"BRACE\"'+
        '},'+
        '\"dateOfBirth\": \"2000-04-06\",'+
        '\"roleCode\": \"AD\",'+
        '\"roleDescription\": \"Adult\",'+
        '\"age\": 22,'+
        '\"gender\": \"Male\"'+
        '},'+
        '{'+
        '\"entityId\": \"1214514794\",'+
        '\"name\": {'+
        '\"title\": \"MR\",'+
        '\"forename\": \"KEVIN JOHN\",'+
        '\"surname\": \"BRACE\"'+
        '},'+
        '\"dateOfBirth\": \"1961-09-29\",'+
        '\"roleCode\": \"PP\",'+
        '\"roleDescription\": \"Principal Person\",'+
        '\"age\": 61,'+
        '\"gender\": \"Male\"'+
        '}'+
        ']'+
        '}'+
        ']';
        resultWrapper.result = PointsDetails.parse2(respText);
        return resultWrapper;
    }

}