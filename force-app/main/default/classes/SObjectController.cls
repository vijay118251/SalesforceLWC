public with sharing class SObjectController {
   	public static Map<String,Integer> countRecMap = new Map<String,Integer>();

    @AuraEnabled
    public static List<SObject> retriveSObjectDetails(String ObjectApiName,List<String> fields){
        try {
            if (String.isNotBlank(ObjectApiName)&& !fields.isEmpty()) {
                // Dynamically build and execute SOQL query based on parameters
                String fieldString = String.join(fields,',');
                String Query = 'SELECT ' +fieldString+ ' FROM ' +ObjectApiName+ ' LIMIT 50';
                // Execute the query and process results
                List<SObject> records = Database.query(query);
                return records;
            }
            else {
                return new List<SObject>();
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<SObject> retriveUserRecords(String ObjectApiName,List<String> fields, String ownerID){
        try {
            if (String.isNotBlank(ObjectApiName)&& !fields.isEmpty() && String.isNotBlank(ownerID)) {
                // Dynamically build and execute SOQL query based on parameters
                String fieldString = String.join(fields,',');
                final string wher = 'OwnerId=:ownerID';
                String Query = 'SELECT ' +fieldString+ ' FROM ' +ObjectApiName+ ' WHERE ' + String.escapeSingleQuotes(wher);
                system.debug(query);
                // Execute the query and process results
                List<SObject> records = Database.query(query);
                system.debug('records-->'+records);
                return records;
            }
            else {
                return new List<SObject>();
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
	}
    @AuraEnabled
    public static Id invokeBatch(String ObjectApiName,String ownerID,String newOwnerID ){
        Id JobId = Database.executeBatch(new BatchUpdatorService(ObjectApiName,ownerID,newOwnerID));
        //String jobStatus = [SELECT Id, JobType, Status, JobItemsProcessed, TotalJobItems 
                                //FROM AsyncApexJob WHERE JobType='BatchApex' AND Status='Completed' AND Id=:JobId]?.Status;
        return JobId;
       
    }
    
    public static void processRecordCount(Integer successCount, Integer failureCount) { 
        //countRecMap = new Map<String,Integer>();
        countRecMap.put('successCount',successCount);
        countRecMap.put('failureCount',failureCount);
        system.debug('processRecordCount'+countRecMap);
        RecordCount__e event = new RecordCount__e(Success_Count__c=successCount,Failure_Count__c=failureCount);
        EventBus.publish(event);
    }
}