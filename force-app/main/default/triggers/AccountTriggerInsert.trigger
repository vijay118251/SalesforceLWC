trigger AccountTriggerInsert on Account (after insert,after update) {
    if(Trigger.isInsert &Trigger.isAfter) {
        ContactInsert.insertContacts(Trigger.New);
    }
    
    if(Trigger.isUpdate &Trigger.isAfter) {
        ContactUpdate.updateContactPhone(Trigger.New,Trigger.oldMap);
    }
		
}