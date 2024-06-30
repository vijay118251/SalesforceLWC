public class BatchUpdatorService implements Database.Batchable<sObject>, Database.Stateful{
    
    public String ownerID;
    public String ObjectApiName;
    public String newOwnerID;
    public Integer successCount = 0;
    public Integer failureCount = 0;
    
    public BatchUpdatorService(String ObjectApiName,String ownerID,String newOwnerID) {
        this.ObjectApiName = ObjectApiName;
        this.ownerID = ownerID;
        this.newOwnerID = newOwnerID;
    }
    
	 public Database.QueryLocator start(Database.BatchableContext bc) {
        final string wher = 'OwnerId=:ownerID';
        String query = 'Select Id,OwnerId,Name FROM ' +ObjectApiName+ ' WHERE ' + String.escapeSingleQuotes(wher);
        system.debug(query);
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<SObject> SObjList) {
        List<SObject> newSObjList = new List<SObject>();
        //Schema.DescribeSObjectResult objectDescribe = SObjList[0].getSObjectType().getDescribe();
        //String ObjectName = objectDescribe.getName();
            for(SObject sObj:SObjList) {
                sObj.put('OwnerId',newOwnerID);
                newSObjList.add(sObj);
            }       
      
        List<Database.SaveResult> saveResults = Database.update(newSObjList, false);

        for(Database.SaveResult sr : saveResults) {
            if(sr.isSuccess()) {
                successCount++;
            } else {
                failureCount++;
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error updating sobject Records: ' + err.getStatusCode() + ' - ' + err.getMessage());
                }
            }
        }
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Number of successful records: ' + successCount);
        System.debug('Number of failed records: ' + failureCount);
        SObjectController.processRecordCount(successCount,failureCount);
    }
}