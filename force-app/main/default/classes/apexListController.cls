//Generated for Decodeforce programming test 

public class apexListController{

	public static List<Account> removeDuplicates(List<Account> accountList){
        Set<Id> accIds = new Set<Id>();
        List<Account> uniqueAccounts = new List<Account>();

        for(Account acc:accountList) {
            if(!accIds.contains(acc.Id)) {
                accIds.add(acc.Id);
                uniqueAccounts.add(acc);
            }
        }
		return uniqueAccounts;

	}
}