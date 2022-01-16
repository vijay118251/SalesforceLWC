trigger simpletrigger on Opportunity (before insert,before update) {
    list<opportunity> opplist=trigger.new;
    if(trigger.isupdate && trigger.isbefore) {
        for(opportunity opp:opplist) {
            opportunity oldopp=trigger.OldMap.get(opp.id);
            if(opp.StageName=='Qualification' && oldopp.StageName!='Qualification') {
                opp.Qualified_Date_Time__c=system.now();
            }
        }
    }
    

}