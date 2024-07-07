public class ContactInsert {
    public static void insertContacts(List<Account> accRec) {
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accRec) {
            if(acc.Create_Contact__c) {
                Contact conRec = new Contact();
        		conRec.FirstName='MR';
        		conRec.LastName=acc.Name+'Contact';
        		conRec.Phone= acc.Phone;
           		conRec.AccountId=acc.Id;
            	conList.add(conRec);
            }
            if(acc.Create_Opportunity__c && acc.Active__c=='Yes') {
                Opportunity opp = new Opportunity();
                opp.Name=acc.Name+'Opp';
                opp.StageName='Prospecting';
                opp.CloseDate= System.today();
                opp.AccountId=acc.Id;
                oppList.add(opp);
            }
        }
        if(!conList.isEmpty()) {
            insert conList;
        }
        if(!oppList.isEmpty()) {
            insert oppList;
        }
    }
    
    public static void insertPrimaryContact(List<Contact> conList) {
        Contact accountsWithContacts = [SELECT Id,Primary_Contact__c,AccountId FROM Contact WHERE AccountId =:conList[0].AccountId AND Primary_Contact__c=true ];
        for(Contact con:conList) {
            if(accountsWithContacts!=null && con.Primary_Contact__c==true) {
                con.addError('More than one primary contact can be created');
            }
        }
    }
    
     public static void updatePrimaryContact(List<Contact> conNewRec, Map<Id,Contact> conOldRec) {
        for(Contact con:conNewRec) {
            if(con.Primary_Contact__c!=conOldRec.get(con.Id).Primary_Contact__c) {
                con.addError('Primary Contact Cannot be Changed');
            }
        }
    }


}