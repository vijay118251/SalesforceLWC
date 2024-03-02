public with sharing class dispatcherAccountSelector {
    public List<Account> getSelectorAccount(String recordId) { 
        return[SELECT Id, Name,Type,Industry,AnnualRevenue,Rating
                FROM Account WHERE Id=:recordId];
    }
}