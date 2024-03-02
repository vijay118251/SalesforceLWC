public with sharing class dispatcherAccountController {
    final static string CLASS_NAME = 'dispatcherAccountController';
    final static string REQ_NAME = 'AccountFire';
    /*Wrapper*/
    @TestVisible
    public class AccountWrapper{
        @AuraEnabled
        public Account account { get; set; }
        @AuraEnabled
        public String responseName { get; set; }
    }

    @AuraEnabled
    public static AccountWrapper getAccountDetails(String accid){
    final AccountWrapper accWp = new AccountWrapper();
        system.debug(accwp);
    try {
        final dispatcherAccountSelector selector = new dispatcherAccountSelector();
        system.debug(selector);
        final List<Account> lstacc = selector.getSelectorAccount(accid);
        system.debug(lstacc);
        if(!lstacc.isEmpty()) {
            final Account acc = lstacc[0];
            system.debug(acc);
            accWp.account = acc;
        }
        accWp.responseName=REQ_NAME;
        system.debug(accwp);
    }
    catch(NoDataFoundException e){
        system.debug(e);
    }
    return accWp;
    }
}