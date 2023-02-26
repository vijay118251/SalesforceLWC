/* Author: Vijay M
* Apex Trigger - VehicleTrigger
*/
trigger VehicleTrigger on vehicleInterest__c (after insert,before insert,before update,after update,before delete) {
    
    //Before Insert
    if(Trigger.isInsert && Trigger.isBefore) {
        VehicleTriggerHandler.checkVehicleSunroof(Trigger.new);
    }
    
    //Before Update
    if(Trigger.isUpdate && Trigger.isBefore) {
        VehicleTriggerHandler.noUpdateVehicleName(Trigger.new);
    }
    
    //Before Delete
    if(Trigger.isDelete && Trigger.isBefore) {
        VehicleTriggerHandler.CheckCarStatus(Trigger.old);
    }
    
    //After Insert
    if(Trigger.isInsert && Trigger.isAfter) {
        VehicleTriggerHandler.triggerMethod(Trigger.new);
    }
    
    //After Delete
    if(Trigger.isDelete && Trigger.isAfter) {
        VehicleTriggerHandler.triggerEmail(Trigger.old);
    }
 
}