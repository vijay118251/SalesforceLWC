/* DML Operations */
public with sharing class VehicleDmlController {
    
/* insertMerthod method
handling exceptions */
    public static void insertMethod() {
        try{
            List<vehicleInterest__c> vhRecs = new List<vehicleInterest__c>();
            vehicleInterest__c vh1 = new vehicleInterest__c(Name='BMW X6',Email__c='vvj5413@gmail.com',Customer__c='Vijay LTD',Phone__c ='8778975002',
                                                            Exterior_Color__c='Red',X4_Wheel_Drive__c=true,Type__c='SUV',Sunroof__c=true);
            vehicleInterest__c vh2 = new vehicleInterest__c();
            vhRecs.add(vh1);
            vhRecs.add(vh2);
            /*insert records*/
            insert vhRecs;
        } catch(DMLException e) {
            /*final NoDataFoundException noDataExp = new NoDataFoundException();
            noDataExp.setMessage('Please Fill Name .');
            throw noDataExp;*/
            system.debug('Error Message-->'+e.getMessage());
        }    
    }
    /* insertMerthod method
Database Methods */
        public static void insertDatabaseMethods() {
            List<vehicleInterest__c> vhRecs = new List<vehicleInterest__c> {
                 new vehicleInterest__c(Name='BMW X6',Email__c='vvj5413@gmail.com',Customer__c='Vijay LTD',Phone__c ='8778975002',
                                                                Exterior_Color__c='Red',X4_Wheel_Drive__c=true,Type__c='SUV',Sunroof__c=true),
                 new vehicleInterest__c()};
                Database.SaveResult[] srList = Database.insert(vhRecs,false);
            //success operation
            for(Database.SaveResult sr:srList) {
                if(sr.isSuccess()) {
                    system.debug('Records Inserted-->'+sr.getId());
                } else {
                    // error operation
                    for(Database.Error err: sr.getErrors()) {
                        system.debug('Error Occurred');
                        system.debug(err.getStatusCode()+':'+err.getMessage());
                        system.debug(err.getFields());
                    }
                }
            }
            
        }
}