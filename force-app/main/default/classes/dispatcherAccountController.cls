public with sharing class dispatcherAccountController {
    
    /*Wrapper*/
    @TestVisible
    private class AccountWrapper{
        @AuraEnabled
        public Account account { get; set; }
    }

    @AuraEnabled
    public static AccountWrapper getAccountDetails(String accid){
    final AccountWrapper accWp = new AccountWrapper();
    try {
        final dispatcherAccountSelector selector = new dispatcherAccountSelector();
        final List<Account> lstacc = selector.getSelectorAccount(accid);
        if(!lstacc.isEmpty()) {
            final Account acc = lstacc[0];
            accWp.account = acc;
        }
    }
    catch(NoDataFoundException e){
        system.debug(e);
    }
    return accWp;
    
    }
    public dispatcherAccountController() {

    }
}
