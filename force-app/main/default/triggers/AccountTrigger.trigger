/* Author: Vijay M
* Apex Trigger - AccountTrigger
*/
trigger AccountTrigger on Account (before insert,After Update) {
	//After Update
    if(Trigger.isUpdate && Trigger.isAfter) {
        List<Account> accTriggerList = VehicleTriggerHandler.updateVehicleCustomerAddress(Trigger.new);
        if(!accTriggerList.isEmpty()){
            update accTriggerList[0].vehicleInterests__r;
        }
    }
}