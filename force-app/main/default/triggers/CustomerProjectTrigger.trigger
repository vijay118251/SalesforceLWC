trigger CustomerProjectTrigger on Customer_Project__c (after insert, after update) {
    if(trigger.isAfter) {
        if(trigger.isInsert || trigger.isUpdate) {
            list<Opportunity> opplst= new list<Opportunity>();
            for(Customer_Project__c cp:trigger.new) {
                if(cp.Opportunity__c!=null) {
                    Opportunity opp=new Opportunity();
                    opp.ID=cp.Opportunity__c;
                    opp.Active_Customer_Project__c=(cp.Status__c=='Active');
                    opplst.add(opp);
                }
            }
            try {
                list<Opportunity> opplist=new list<Opportunity>();
                opplist.addAll(opplst);
                update opplist;
            }
            catch(Exception e) {
                System.debug('update operation failed due to this error'+e.getMessage());
            }
        }
    }

}