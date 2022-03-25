public with sharing class AccountElementController {

public static final string CLASS_NAME = 'AccountElementController';

    /*Wrapper class*/
    public Class AccountWrapper {
        @AuraEnabled
        public Account account {get; set;}
        @AuraEnabled
        public List<Case> accCase {get; set;}
        @AuraEnabled
        public Request command {get; set;}
    }

    public Class Request {
        @AuraEnabled
        public String method {get; set;}
        @AuraEnabled
        public String identifier {get; set;}
    }

    public static AccountWrapper selectFromId(String accId) {
        final AccountWrapper accWp = new AccountWrapper();
        if(accId!=null && hasUserGotObjectAccess()) {
            try {
                final AccountSelector selector = new AccountSelector();
                selector.setStripInaccessible(true);
                final Account acc = selector.selectFromMethod(new Set<Id> {accId} );
                final List<Case> cases = selector.caseMethod(new Set<Id> {accId});
                if(acc!=null || !cases.isEmpty()) {
                    accWp.account = acc;
                    System.debug(accWp.account);
                    accWp.accCase = cases;
                    System.debug(accWp.accCase);
                }
            }
            catch(NoDataFoundException e){
        		system.debug(e);
            }
        }
        final Request req = new Request();
        req.method = 'selectfromId';
        req.identifier = accId;
        accWp.command = req;
        System.debug(accWp);
        return accWp;
    }

    /* object access */
    public static boolean hasUserGotObjectAccess() {
        if(
            Schema.SObjectType.Account.isAccessible() &&
            Schema.SObjectType.Case.isAccessible()
        ) {
            return true;
        } else {
            throw new NoAccessException();
        }

    }
}