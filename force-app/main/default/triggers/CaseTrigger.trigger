trigger CaseTrigger on Case (Before Insert) {     
    if(Trigger.isInsert && Trigger.isBefore){                 
        CaseTriggerHandler.beforeInsert(Trigger.New
                                       );         
    }  
}