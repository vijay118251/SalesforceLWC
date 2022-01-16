trigger Createcontact5 on Contact (after insert,after undelete,after delete) {
    if(trigger.isAfter ) {
        if(trigger.isInsert) {
            list<Contact_Relationship__c> conrels=new list<Contact_Relationship__c>();
            for(Contact cts: [select ID,Name from Contact where ID in :trigger.new AND Contact_Relationship__c=TRUE]){
                Contact_Relationship__c conrel=new Contact_Relationship__c();
                conrel.Name=cts.Name;
                conrel.Contact__c=cts.ID;
                conrels.add(conrel);
            }
            try{
                insert conrels;
            } 
            catch(Exception e) {
                system.debug('Insert operation aborted due to error'+ e.getMessage());
            }   
        } 
    }
    if(trigger.isAfter ) {
        if(trigger.isUndelete) {
            list<Contact_Relationship__c> conrels1=new list<Contact_Relationship__c>();
            conrels1.addAll([select ID from Contact_Relationship__c where Contact__c in :trigger.new ALL ROWS]);
            try {
                    undelete conrels1;
                } 
            catch(Exception e) {
                system.debug('Undelete operation aborted due to error'+ e.getMessage());
            }   
        } 
    }
    if(trigger.isAfter ) {
        if(trigger.isdelete) {
            list<Contact_Relationship__c> conrels2=[select ID from Contact_Relationship__c where Contact__c in :trigger.old];
            try {
                    delete conrels2;
                } 
            catch(Exception e) {
                system.debug('delete operation aborted due to error'+ e.getMessage());
            }   
        } 
    }
    
}