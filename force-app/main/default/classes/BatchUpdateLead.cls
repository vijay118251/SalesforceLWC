public class BatchUpdateLead implements Database.Batchable<sObject> {
    /* start method*/
    public Database.QueryLocator start(Database.BatchableContext bc) {
        final String Lead_Source='Partner Referral';
        /** query **/
        return Database.getQueryLocator('SELECT Id, Name, Phone, Email, Website, Description, LeadSource, Status, Industry, Rating, AnnualRevenue FROM Lead WHERE LeadSource=:Lead_Source');
    }

    /* Execute method*/
    public void execute(Database.BatchableContext bc,List<Lead> lstLead) {
        List<Lead> leadtoPass = lstLead; 
        final Map<String, List<Lead>> leadParams = new Map<String, List<Lead>>();
        leadParams.put('inputLeadRecords',leadtoPass);
        System.debug('flow map-->'+leadParams);
        Flow.interview.BatchLeadSchedular oppFlow = new Flow.interview.BatchLeadSchedular(leadParams);
        oppFlow.start();
    }

    /* Finsih method*/
    public void finish(Database.BatchableContext bc) {
        //Logic to be executed at finish
    }
}