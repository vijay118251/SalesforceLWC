/* @author  Vijay M
* <Purpose> To update vehicle model <Purpose> */
public class VehicleFutureApex {
    
    
    /* future method */
    @future
    public static void checkSunroof(){
        /** query**/
        List<vehicleInterest__c> vhList =[SELECT Id, Name, Exterior_Color__c, Type__c, X4_Wheel_Drive__c, 
                                  Customer__c, Sunroof__c, Email__c, Model__c FROM vehicleInterest__c where Id IN:([SELECT Id From vehicleInterest__c])];
        system.debug('vhList-->'+vhList);
        for(vehicleInterest__c vh:vhList) {
            if(vh.Sunroof__c==true) {
                vh.Model__c='Automatic';
            } else {
                vh.Model__c='Manual';
            }
        }
        
        //update records
        if(!vhList.isEmpty()){
            update vhList;
        }
    }

}