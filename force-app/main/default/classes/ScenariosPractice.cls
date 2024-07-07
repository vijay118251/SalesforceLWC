public class ScenariosPractice {
    
    //s1: • Insert Vehicle Records for accounts which is having active and annual revenue >500000
    public static void createVehicleInterest(){
        List<Account> accList = [SELECT Id, Name, Active__c, AnnualRevenue FROM Account where Active__c = 'Yes' AND AnnualRevenue > 500000];
    	System.debug('accList-->'+accList);
        List<vehicleInterest__c> vh = new List<vehicleInterest__c>();
        for(Account acc : accList){
            vehicleInterest__c vi = new vehicleInterest__c(Name = 'test'+acc.Name , Account__c = acc.Id);
            vh.Add(vi);         
        }
        if(!vh.isEmpty()){
            insert vh;
        }       
    }
    
   //s2: Update Phone field of Vehicle Records from associated account which is having phone number
    public static void updatePhoneField(){
        List<vehicleInterest__c> vhList = [SELECT Id,Name,Phone__c,Account__r.Phone  FROM vehicleInterest__c WHERE Account__c != null];
        for(vehicleInterest__c vh : vhList){
            if(vh.Phone__c == null){
                vh.Phone__c = vh.Account__r.Phone;
            }
        }
        if(!vhList.isEmpty()){
            update vhList;
        }
       //System.debug('vhList-->'+vhList); 
    }
    
    //s3: •  Query all vehicle records convert to map. Store all id into a set and again store map values into new list
    public static void ConvertToMapAndSet(){
        List<vehicleInterest__c> vehicles = [SELECT Id,Name FROM vehicleInterest__c];
        System.debug('vehicles-->'+vehicles);
        Map<Id,vehicleInterest__c> vehiclesMap = new Map<Id,vehicleInterest__c>(vehicles);
        System.debug('vehiclesMap-->'+vehiclesMap);
        Set<Id> vehiclesIds = new Set<Id>(vehiclesMap.KeySet());
        System.debug('vehiclesIds-->'+vehiclesIds);
        List<vehicleInterest__c> newVehicles = new List<vehicleInterest__c>();
        for(Id id : vehiclesMap.KeySet()){
            newVehicles.Add(vehiclesMap.get(id));
        }
        System.debug('newVehicles-->'+newVehicles);
    }
    
    
    
    public static void CreateAccount(Integer num){
        List<Account> accList = new List<Account>();
        for(Integer i =1 ; i<=num ; i++){
            Account acc = new Account(Name='VehicleAccount'+i , AccountNumber='UK');
            accList.Add(acc);
        }
        insert accList;
        List<vehicleInterest__c> vhList = new List<vehicleInterest__c>();
        for(Account acc : accList){
            for(Integer i =1 ; i<=acc.AccountNumber.length() ; i++){
                vehicleInterest__c vh = new vehicleInterest__c(Name = 'TEST'+acc.Name+i , Account__c = acc.Id);
                vhList.Add(vh);
            }
        }
        insert vhList;
    }
    
    public static void UpdateWebsite(string website){
        List<vehicleInterest__c> vhList = [SELECT Id,Account_Website__c,Account__r.Name FROM vehicleInterest__c WHERE Account__r.Name='VehicleAccount1'];
        List<Account> accList = [SELECT Id,	Website, (SELECT Id, Account_Website__c FROM Vehicle_Interests__r) FROM Account WHERE Name = 'VehicleAccount1'];
        for(Account acc : accList){
            if(acc.Website == null){
                acc.Website = website;              
            }
            for(vehicleInterest__c vh : vhList){
                vh.Account_Website__c = acc.Website;
            }
        }
        System.debug('acclist-->'+accList);
        System.debug('vhList-->'+vhList);
        update accList;
        update vhList;
    }
    
    
    
    
    
    
    
    
    
    
    
    
}