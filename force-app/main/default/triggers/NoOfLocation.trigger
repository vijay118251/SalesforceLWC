trigger NoOfLocation on Account (after insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            list<Contact> conlist=new list<Contact>();
            for(Account acc:trigger.new) {
                for(Integer i=1;i<=acc.NumberofLocations__c;i++) {
                    Contact con=new Contact();
                    con.LastName='Trigger Test' +i;
                    con.AccountId=acc.ID;
                    conlist.add(con);
                }
            }
            try {
                insert conlist;
            }
            catch(Exception e){
                system.debug('Insert operation failed due to this error'+e.getMessage());
            }
        }
    }
    
}