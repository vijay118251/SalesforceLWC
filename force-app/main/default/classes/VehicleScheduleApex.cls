/* @author  Vijay M
* <Purpose> Schedule apex to call VehicleQueueableApex <Purpose> */
public class VehicleScheduleApex implements Schedulable{
    
    // execute method
    public void execute(SchedulableContext sc) {
        system.enqueueJob(new VehicleQueueableApex('Cold'));
    }
    

}