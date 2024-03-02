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
            if(String.isNotBlank(vh.No_of_Contacts__c)) {
                insertContact(vhRecs);
            }
            else if(vh.Email__c=='deepug@gmail.com'){
                Account acc = new Account(Name='Deepika Goura',Phone='7013300177',AnnualRevenue=950000000.00);
                accList.add(acc);
            }
        }
        //Insert Records
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    public static void insertContact(List<vehicleInterest__c> vhRecs) {
        system.debug('insertContact method called');
        List<Contact> conList = new List<Contact>();
        for(vehicleInterest__c vh:vhRecs){
            if(String.isNotBlank(vh.No_of_Contacts__c)){
                for(integer i=1;i<=integer.valueOf(vh.No_of_Contacts__c);i++) {
                    Contact con = new Contact();
                    con.FirstName=string.valueOf(i);
                    con.LastName=vh.Name;
                    con.Phone=vh.Phone__c;
                    con.Email=vh.Email__c;
                    con.vehicleContact__c=vh.Id;
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()) {
            insert conList;
        }
    }
    
    //Method - UpdateContactCount
    public static void UpdateContactCount(List<vehicleInterest__c> vhNewRecs,Map<Id,vehicleInterest__c> vhOldRecs) {
        List<Contact> conList = new List<Contact>();
        for(vehicleInterest__c vh:vhNewRecs) {
            if(vh.No_of_Contacts__c!=vhOldRecs.get(vh.Id).No_of_Contacts__c && vhNewRecs!=null && vhOldRecs!=null ) {
                Integer count = integer.valueOf(vhOldRecs.get(vh.Id).No_of_Contacts__c);
                if(integer.valueOf(vh.No_of_Contacts__c)>count) {
                    Integer recToCreate = integer.valueOf(vh.No_of_Contacts__c)-integer.valueOf(vhOldRecs.get(vh.Id).No_of_Contacts__c);
                    for(integer i=1;i<=recToCreate;i++) {
                    Contact con = new Contact();
                    con.FirstName='Updated'+string.valueOf(i);
                    con.LastName=vh.Name;
                    con.Phone=vh.Phone__c;
                    con.Email=vh.Email__c;
                    con.vehicleContact__c=vh.Id;
                    conList.add(con);
                 }
               }
                else {
                    Integer recToDelete = integer.valueOf(vhOldRecs.get(vh.Id).No_of_Contacts__c)-integer.valueOf(vh.No_of_Contacts__c);
                    DELETE[SELECT Id,Name FROM Contact WHERE vehicleContact__c=:vh.Id order by CreatedDate desc LIMIT :recToDelete];
                }
            }
        }
         if(!conList.isEmpty()) {
            insert conList;
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