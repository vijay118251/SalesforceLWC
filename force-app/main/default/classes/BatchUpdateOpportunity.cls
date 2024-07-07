public class BatchUpdateOpportunity implements Database.Batchable<sObject> {
    /* start method*/
    public Database.QueryLocator start(Database.BatchableContext bc) {
        final String Opp_Type='New Customer';
        /** query **/
        return Database.getQueryLocator('SELECT Id,Type FROM Opportunity WHERE Type=:Opp_Type');
    }

    /* Execute method*/
    public void execute(Database.BatchableContext bc,List<Opportunity> lstOpp) {
        final Map<String, Object> oppParams = new Map<String, Object>();
        oppParams.put('inputOpportunityIds',UtilityFlow.getCommaStringByObject(lstOpp));
        System.debug('flow map-->'+oppParams);
        Flow.interview.BatchOpportunitySchedular oppFlow = new Flow.interview.BatchOpportunitySchedular(oppParams);
        oppFlow.start();
    }

    /* Finsih method*/
    public void finish(Database.BatchableContext bc) {
        //Logic to be executed at finish
    }

    /*Invocable Method to convert String*/
    @InvocableMethod(label='Convert Text of String to List String')
    public static List<List<sObject>> getOppIds(List<UtilityFlow.SoqlInputs> soqlOpp) {
        return UtilityFlow.getRecordByIds(soqlOpp[0]);

    }

    /* Execute Schedule */
    // public static void execute(SchedulableContext SchCon) {
    //     final BatchUpdateOpportunity updateOpp = new BatchUpdateOpportunity();
    //     final Integer batchSize = (Integer) batchMetadata__mdt.getInstance('opportunityBatch').Batch_Size__c;
    //     Database.executeBatch(updateOpp, batchSize);
    // }

}