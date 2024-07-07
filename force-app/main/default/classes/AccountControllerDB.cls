public with sharing class AccountControllerDB {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData() {
        return [SELECT Id, Name, Industry, Type FROM Account LIMIT 10];
    }
}