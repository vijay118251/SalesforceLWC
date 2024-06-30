public with sharing class dispatcherAccountSelector {
    public List<Account> getSelectorAccount(String recordId) { 
        return[SELECT Id, Name,Type,Industry,AnnualRevenue
                FROM Account WHERE Id=:recordId];
    }
}
