//Generated for Decodeforce programming test
public class caseTriggerHandler{

	public static void beforeInsert(List<Case> caseList){
        List<Case> caseToUpdate = new List<Case>();
		/* Write your logic below */
        Set<Id> accId = new Set<Id>();
        for(Case cse:caseList) {
            if(cse.AccountId!=null)
            accId.add(cse.AccountId);
        }

        List<Case> caseWithAccounts = [Select Id,Account.Rating From Case Where AccountId IN:accId];
        for(Case cs:caseWithAccounts) {
            if(cs.Account.Rating=='Hot') {
                cs.Priority='High';
            }
            else if(cs.Account.Rating=='Warm') {
                cs.Priority='Medium';
            }
            else {
                cs.Priority='Low';
            }
            caseToUpdate.add(cs);
        } 

        if(!caseToUpdate.isEmpty()) {
            insert caseToUpdate;
        }
	}
}