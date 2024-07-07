//Generated for Decodeforce programming test
public class opportunityProductsController{

	public static List<Account> findRelatedAccounts(String productId){

		List<Account> accountList = new List<Account>();

		/* Write your logic below */
        Set<Id> oppId = new Set<Id>();
        Set<Id> accId = new Set<Id>();
        List<OpportunityLineItem> oppLineItems = [Select Id,Opportunity.Id 
                                                 From OpportunityLineItem 
                                                 Where Id =:productId];
        for(OpportunityLineItem oppLineItem : oppLineItems) {
            oppId.add(oppLineItem.Opportunity.Id);
        }

        if(!oppId.isEmpty()) {
            accountList = [Select Id From Account Where Id IN (Select AccountId From Opportunity where Id IN:oppId)];
        }

		return accountList;
	}
}