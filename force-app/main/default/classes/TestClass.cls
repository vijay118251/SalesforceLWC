public with sharing class TestClass{
	public TestClass(){}
	
	@AuraEnabled(cacheable=true)
	public static List<Account> getAccounts() {
		return [select id,name,type from Account LIMIT 10];
	}

	@AuraEnabled(cacheable=true)
	public static List<Opportunity> getAssociatedOpportunities(String accId) {
		return [ SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunity where AccountId  =: accId ];
	}

	@AuraEnabled(cacheable=true)
	public static List<Contact> getAssociatedContacts(String accId) {
		return [SELECT Id, Name, Birthdate FROM Contact where AccountId =: accId ];
	}

	@AuraEnabled(cacheable=true)
	public static Account getAccount(){
		return [SELECT Id, Name, AccountNumber, Industry 
				FROM Account 
				WITH SECURITY_ENFORCED 
				LIMIT 1];
	}

	
}