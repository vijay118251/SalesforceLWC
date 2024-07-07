public class ContactUpdate {
    public static void updateContactPhone(List<Account> accNewRec, Map<Id,Account> accOldRec) {
        List<Contact>  conList = new List<Contact>();
        Map<Id,Account> accMap = new  Map<Id,Account>();
        for(Account acc:accNewRec) {
            if(acc.Phone!=null && acc.Phone!=accOldRec.get(acc.Id).Phone) {
                accMap.put(acc.Id, acc);
            }
        }
        List<Contact> conNewList = [Select Id,AccountId,Phone,Account.Phone FROM Contact WHERE AccountId IN:accMap.keySet()];
        for(Contact con:conNewList) {
            con.Phone=accMap.get(con.AccountId).Phone;
            conList.add(con);
        }
        update conList;
    }
	
}