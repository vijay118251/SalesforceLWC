/* Author: Vijay M
* Apex Trigger - VehicleTriggerHandler
*/
public class VehicleTriggerHandler {
    
    // Method - checkVehicleSunroof
    // Throw error for Vehicle Interest Record if Sunroof is not checked
    public static void checkVehicleSunroof(List<vehicleInterest__c> vhRecs){
        for(vehicleInterest__c vh:vhRecs){
            if(vh.Sunroof__c==false && vh.Model__c.startsWith('X')){
                //throw error on model field
                vh.Model__c.addError('Please Check Sunroof for BMW X-Series');
            }
        }
    }
    
    // Method - noUpdateVehicleName
    // Throw error on Vehicle Record if Name is updated
    public static void noUpdateVehicleName(List<vehicleInterest__c> vhRecs){
        system.debug('New values'+Trigger.newMap);
        system.debug('Old values'+Trigger.oldMap);
        for(vehicleInterest__c vhNew:vhRecs) {
            vehicleInterest__c vhOld=(vehicleInterest__c) Trigger.oldMap.get(vhNew.Id);
            if(vhNew.Name != vhOld.Name) {
                vhNew.addError('Vehicle Name cannot be Modified Once Created'); 
            }
            
        }
        
    }
    
    // Method - triggerMethod
    // Throw error for deleting Vehicle Interest Record which are having car status available
    public static void CheckCarStatus(List<vehicleInterest__c> vhRecs){
        for(vehicleInterest__c vh:vhRecs){
            if(vh.carStatus__c=='Available'){
                vh.addError('Cannot Delete Records Which are in Availble Status');
            }
        }
    }
    
    // Method - triggerMethod
    // Insert Account Record when Vehicle Interest Record is Created
    public static void triggerMethod(List<vehicleInterest__c> vhRecs){
        List<Account> accList = new List<Account>();
        for(vehicleInterest__c vh:vhRecs){
            if(vh.Email__c=='deepug@gmail.com'){
                Account acc = new Account(Name='Deepika Goura',Phone='7013300177',AnnualRevenue=950000000.00);
                accList.add(acc);
            }
        }
        //Insert Records
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    // Method - updateVehicleCustomerAddress
    // Update Vehicle Customer Address With Associated Account Billing Address
    public static List<Account> updateVehicleCustomerAddress(List<Account> accRecs) {
        system.debug('Triggered Record'+accRecs);
        List<Account> accList = [SELECT Id,Name,BillingAddress,(Select Id,customerAddress__c,Email__c FROM vehicleInterests__r) FROM Account WHERE Id IN:accRecs];
        for(Account acc:accList) {
            if(acc.BillingAddress!=null){
                for(vehicleInterest__c acVhRec:acc.vehicleInterests__r) {
                    acVhRec.customerAddress__c=String.valueOf(acc.BillingAddress);
                }
            }
        }
        return accList;
    }
    
    // Method - triggerEmail
    // Send Email to User when record is deleted
    public static void triggerEmail(List<vehicleInterest__c> vhRecs) {
        List<Messaging.SingleEmailMessage> emailObjs = new List<Messaging.SingleEmailMessage>();
        List<String> emailAddress = new List<String>();
        emailAddress.add(UserInfo.getUserEmail());
        Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
        emailObj.setToAddresses(emailAddress);
        emailObj.setPlainTextBody('Tesy Mail Vehicle Records');
        emailObj.setSubject('Vehicle Record has been successfully Deleted');
        emailObjs.add(emailObj);
        Messaging.sendEmail(emailObjs);
    }
}