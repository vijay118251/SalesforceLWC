public with sharing class AccountSelector {

    /* security*/
    public Boolean enforceSecurity = false;
    /* strip inaccessible*/
    public Boolean stripInaccessible = false;
    /* Order By*/
    public String orderBy = null;
    /* Field Set */
    public final List<FieldGroup> fieldSet = new List<FieldGroup>();
    /* Enum Field Group*/
    public enum FieldGroup { TESTACCOUNT, TESTCASE }

    /* strip inaccessible method*/
    public Boolean setStripInaccessible(Boolean strip) {
        return this.stripInaccessible = strip;
        
    }
    
    /* set enfroce security method*/
    public Boolean setEnforceSecurity(Boolean enforce) {
        return this.enforceSecurity = enforce;   
    }

    /* return set of account fields */
    public static Set<String> getAccountFields() {
        return new Set<String> {'Id',
                                'Name',
                                'Type',
                                'Industry',
                                'AnnualRevenue',
                                'Description',
                                'BillingStreet',
                                'BillingCity',
                                'BillingState',
                                'Phone',
                                'Rating',
                                'Site',
                                'AccountSource',
                                'Active__c',
                                'NumberofLocations__c'};
    }

    /* return set of account fields */
    public static Set<String> getCaseFields() {
        return new Set<String> {'Id',
                                'CaseNumber',
                                'AccountId',
                                'Type',
                                'Status',
                                'Reason',
                                'Origin',
                                'Priority',
                                'Description',
                                'SLAViolation__c',
                                'Product__c',
                                'PotentialLiability__c'};
    }

    /*Constructor*/
    public AccountSelector() {
        this.fieldSet.add(FieldGroup.TESTACCOUNT);
        this.fieldSet.add(FieldGroup.TESTCASE);
    }

    /*getFieldList for Account*/
    public List<String> getFieldList() {
        final List<String> returnList = new List<String>();
        /*Account*/
        if(this.fieldSet.contains(FieldGroup.TESTACCOUNT)) {
            returnList.addAll(getAccountFields());
        }
        return returnList;
    }
    
    /*getFieldList for Case */
    public List<String> getCaseFieldList() {
        final List<String> returnCaseList = new List<String>();
        /*Case*/
        if(this.fieldSet.contains(FieldGroup.TESTCASE)) {
            returnCaseList.addAll(getCaseFields());
        }
        return returnCaseList;
    }

    /*selectFromMethod*/
    public Account selectFromMethod(Set<Id> accountID) {
        Account acc = new Account();
        final string wher = 'Id IN :accountId';
        final String execQuery = generateQueryString(getFieldList(), wher, this.orderBy, this.enforceSecurity);
        system.debug('exe'+execQuery);
        acc = Database.query(execQuery);
        return acc;
    }

    /* generate dynamic query for account object */
    public static String generateQueryString(List<String> fields, String wher, String order, Boolean enforceSecurity) {
        return 'SELECT ' + String.join(fields,', ') + ' FROM Account' + ' WHERE ' + String.escapeSingleQuotes(wher) + 
        (enforceSecurity ? ' WITH SECURITY_ENFORCED' : '') 
        + ' LIMIT 1';
    }
    
     /* generate dynamic query for case object */
    public static String generateCaseQueryString(List<String> fields, String wher, String order, Boolean enforceSecurity) {
        return 'SELECT ' + String.join(fields,', ') + ' FROM Case' + ' WHERE ' + String.escapeSingleQuotes(wher);
    }
 
    /*caseMethod*/
    public List<Case> caseMethod(Set<Id> accID) {
        List<Case> cse = new List<Case>();
        final string wher = 'AccountId IN :accID';
        final String execQuery = generateCaseQueryString(getCaseFieldList(), wher, this.orderBy, this.enforceSecurity);
        cse = Database.query(execQuery);
        return cse;
    }
}