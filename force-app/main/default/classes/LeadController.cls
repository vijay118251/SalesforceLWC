public with sharing class LeadController {

    public class LeadWrapper {
        @AuraEnabled
        public List<Lead> leads;
        @AuraEnabled
        public String params;

    private LeadWrapper() {

    }
    }

    @AuraEnabled
    public static LeadWrapper getLeadsRecords(String name,Double annualRevenue) {
        final LeadWrapper wrap = new LeadWrapper();
        try {
            if(leadObjAccess() && String.isBlank(name) && annualRevenue==null ) {
                    List<Lead> ldList = [SELECT Id,Name,Company,Title,Email,Status FROM Lead WITH SECURITY_ENFORCED];
                        if(!ldList.isEmpty()) {
                            wrap.leads = ldList;
                            wrap.params=name;
                        }
            }
            else if(leadObjAccess() && String.isNotBlank(name) && annualRevenue!=null ) {
               List<Lead> ldList = [SELECT Id,Name,Company,Title,Email,Status FROM Lead 
               WHERE Name=:name AND AnnualRevenue=:annualRevenue
                WITH SECURITY_ENFORCED];
                        if(!ldList.isEmpty()) {
                            wrap.leads = ldList;
                            wrap.params=name;
                        }
            }
        }
        catch (Exception e) {
           //Add your custom error messsage to the AuraHandledException, you can add any string here
           throw newMessageException('Lead Data Failed : ' + e.getMessage());
        }
        return wrap;
    }

    public static Boolean leadObjAccess() {
        if(schema.sObjectType.Lead.isAccessible()) {
            return true;
        }
        else {
            throw new NoAccessException();
        }
    }

    private static AuraHandledException newMessageException(String message) {
    AuraHandledException e = new AuraHandledException(message);
    e.setMessage(message);
    return e;
  }

}