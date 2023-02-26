/* @author  Vijay M
* <Purpose> To Create vehicle record for account
where Rating is Cold <Purpose> */
public class VehicleQueueableApex implements Queueable {
    
    private Integer records=0;
    public String accRating;
    
    //constructor
    public VehicleQueueableApex(String rating){
        this.accRating=rating;
    }
    
    // execute method
    public void execute(QueueableContext qc) {
        List<Account> accList =[SELECT Id, Name,Phone, Type, Rating, Active__c
                                FROM Account WHERE Rating=:accRating];
        List<vehicleInterest__c> vhList = new  List<vehicleInterest__c>();
        for(Account acc:accList) {
            vehicleInterest__c vhInsert = new vehicleInterest__c(Name='Range Rover',Email__c=acc.Rating+'@gmail.com',Customer__c=acc.Name,
                                                                 Phone__c =acc.Phone,Exterior_Color__c='Gold',X4_Wheel_Drive__c=true,
                                                                 Type__c='SUV',Sunroof__c=true,Account__c=acc.Id);
            vhList.add(vhInsert);
            records++;
            system.debug('count-->'+records);
                }
        if(!vhList.isEmpty()){
            insert vhList;
        }
    }
}