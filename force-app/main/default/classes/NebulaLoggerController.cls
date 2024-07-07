public with sharing class NebulaLoggerController {
	public Account accDetails;
    public Account createLogs() {
        try {
            Logger.debug('Add log entry using Nebula Logger');
            Account acct = [SELECT Id, Name, Phone, Website, AccountNumber FROM Account];
			Logger.info('Add log entry using Nebula Logger with logging level == DEBUG'+acct);
            logger.saveLog();
            this.accDetails=acct;
        }
        catch(Exception e) {
            // This will create a new `Log__c` record with multiple related `LogEntry__c` records
			Logger.error('Add log entry using Nebula Logger with logging level == ERROR'+e);
            
        }
        return accDetails;
    }
}