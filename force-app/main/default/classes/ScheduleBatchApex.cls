public class ScheduleBatchApex implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new UpdateBatchApex(),2000);
    } 
}