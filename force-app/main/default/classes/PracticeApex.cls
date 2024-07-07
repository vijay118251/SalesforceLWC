public class PracticeApex {
    static Boolean check;
    
    public static void method() {
        check = true;
        String name = check? 'Vijay':'Mathivanan';
        system.debug('check-->'+name);
    }
    
    public static void collections() {
        List<String> lstStr = new List<String> {'Chennai','Nellore','Madurai'};
            String str = String.join(lstStr,',');
        Set<String> setStr = new Set<String>(lstStr);
        Map<String,String> mapStr = new Map<String,String>{'1' => 'Chennai','2' => 'Nellore','3' => 'Madurai'};
            Map<String,String> mapLst = new Map<String,String>();
        for(Integer i=0; i<lstStr.size();i++) {
            mapLst.put(String.valueOf(i+1),lstStr.get(i));                                                                 
        }  
    }
    
    public static void query() {
        List<Account> accList = [Select Id,Name FROM Account LIMIT 10];
        Map<Id,Account> mapAcc = new Map<Id,Account>([Select Id,Name FROM Account WHERE Rating='Cold']);
        Set<Id> accIds = new Set<Id>();
        Set<Id> filteredIds = new Set<Id>();
        List<Account> updateList = new List<Account>();
        for(Account acc:accList) {
            accIds.add(acc.Id);
        }
        if(!accIds.isEmpty()) {
            for(Id accId:accIds) {
                if(mapAcc.containsKey(accId)) {
                    filteredIds.add(accId);
                } 
            }
            List<Account> filteredAccounts = [Select Id,Name,Site FROM Account WHERE Id IN:filteredIds];
            for(Account acc:filteredAccounts) {
                acc.Site='monkySoul.com';
                updateList.add(acc);
            }
        }
        
        if(!updateList.isEmpty()) {
            update updateList;
        }
    }
    
    public static void dmlOperation() {
        List<vehicleInterest__c> accList = new List<vehicleInterest__c> {
            new vehicleInterest__c(Name='Mahindra XUV 700')
        };
        Database.SaveResult[] srList = Database.Insert(accList,false);
        for(Database.SaveResult sr:srList) {
            if(sr.isSuccess()) {
                System.debug('Id of Record'+sr.getId());
            }
            else {
                for(Database.Error err:sr.getErrors()) {
                    System.debug('Error Occured due to '+err.getMessage());
                    System.debug('Status Code '+err.getStatusCode()+ 'Fields '+err.getFields());
                }
            }
        }
    }
}