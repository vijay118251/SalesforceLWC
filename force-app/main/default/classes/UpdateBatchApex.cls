public class UpdateBatchApex implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'Select Id, Entity_Number__c, Contact_Member__c FROM Contact';
        system.debug(query);
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> conList) {
        List<Contact> cons = new List<Contact>();
        for(Contact con:conList) {
            Account acc = [Select Id,Entity_Number__c FROM Account WHERE Entity_Number__c=:con.Entity_Number__c LIMIT 1];
            system.debug(acc);
            con.Contact_Member__c = acc.Id;
            system.debug(con.Contact_Member__c);
            cons.add(con);
        }
        update cons;
    }
    
    public void finish(Database.BatchableContext bc) {
        system.debug('Batch Job Completed');
    }
}