public with sharing class opportunitycontroller {
    public opportunitycontroller() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunityRecords() {
        List<Opportunity> opplist = [Select id,Name,Amount,CloseDate,StageName from Opportunity];
        return opplist;
    }
}