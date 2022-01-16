trigger trigger2 on Contact (after insert,after delete,after undelete) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            list<ID> accid=new list<ID>();
            for(Contact cts:trigger.new)
                accid.add(cts.AccountId);
            List<Account> accts=new List<Account>();
            for(Account acct:[select ID,(select ID from Contacts)from Account where ID in :accid]) {
                acct.Count_of_contacts__c=acct.contacts.size();
                accts.add(acct);
            }
            
             try {
                    update accts;
                } 
            catch(Exception e) {
                system.debug('update operation aborted due to error'+ e.getMessage());
            }   
        }
    }
    if(trigger.isAfter) {
        if(trigger.isDelete) {
            Set<ID> accid=new Set<ID>();
            for(Contact cts:trigger.old)
                accid.add(cts.AccountId);
            List<Account> accts=new List<Account>();
            for(Account acct:[select ID,(select ID from Contacts)from Account where ID in :accid]) {
                acct.Count_of_contacts__c=acct.contacts.size();
                accts.add(acct);
            }
        }
    }

}