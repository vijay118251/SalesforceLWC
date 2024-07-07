trigger ContactTrigger on Contact (before insert,before update) {
    if(Trigger.isInsert && Trigger.isBefore) {
        //ContactInsert.insertPrimaryContact(Trigger.New);
    }
     if(Trigger.isUpdate && Trigger.isBefore) {
        //ContactInsert.updatePrimaryContact(Trigger.New,Trigger.OldMap);
    }

}