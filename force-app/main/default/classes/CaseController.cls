public with sharing class CaseController {
    public CaseController() {

    }
    public static Integer CaseStatus=0;
    public static void UpdateAccountRating(List<Case> caseList) {
        Set<Id> accIds = new Set<Id>();
        for (Case cse : caseList) {
            accIds.add(cse.AccountId);
        }

        List<Account> accList = [Select Id,Rating,(Select Id,Status From Cases) From Account WHERE Id IN:accIds];
        System.debug(accList);
        List<Account> updateAccounts = new List<Account>();
        if(!accList.isEmpty()) {
            for (Account acc : accList) {
                for (Case cs : acc.Cases) {
                    if(cs.Status=='Closed') {
                        CaseStatus++;
                    }
                }
                System.debug(CaseStatus);
                acc.Rating = CaseStatus < 2 ? 'Cold' : CaseStatus > 2 ? 'Warm' : CaseStatus > 5 ? 'Hot' : '';
                updateAccounts.add(acc);
            }
        }

        if(!updateAccounts.isEmpty()) {
            update updateAccounts;
        }
    }

    public static void UpdateCaseAccountRating(List<Case> caseList,Map<Id, Case> caseMap) {
        System.debug(caseList);
        System.debug(caseMap);
        Set<Id> accIds = new Set<Id>();
        for (Case cse : caseList) {
            if(cse.Status!=caseMap.get(cse.Id).Status) {
                accIds.add(cse.AccountId);
            }
        }

        List<Account> accList = [Select Id,Rating,(Select Id,Status From Cases) From Account WHERE Id IN:accIds];
        System.debug(accList);
        List<Account> updateAccounts = new List<Account>();
        if(!accList.isEmpty() && caseMap!=null) {
            for (Account acc : accList) {
                for (Case cs : acc.Cases) {
                    if(cs.Status=='Closed') {
                        CaseStatus++;
                    }
                }
                System.debug(CaseStatus);
                acc.Rating = CaseStatus < 2 ? 'Cold' : CaseStatus > 2 ? 'Warm' : CaseStatus > 5 ? 'Hot' : '';
                updateAccounts.add(acc);
            }
        }

        if(!updateAccounts.isEmpty()) {
            update updateAccounts;
        }
    }
}