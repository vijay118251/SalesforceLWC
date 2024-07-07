public with sharing class UtilityFlow {

    @TestVisible
    private UtilityFlow() {
        //constructor
    }

    /* wrapper class*/
    public class SoqlInputs {
        /* Object Name*/
        @InvocableVariable
        public String objectName;
        /* Field Name*/
        @InvocableVariable
        public String fieldName;
        /*recIds*/
        @InvocableVariable
        public String recIds;
    }

    public static String getCommaStringByObject(List<sObject> lstObj) {
        final Map<String, sObject> mapObj = new Map<String, sObject>(lstObj);
        return '\''+String.join(new List<String>(mapObj.keySet()),'\',\'')+'\'';

    }

    public static List<List<sObject>> getRecordByIds(SoqlInputs inputVal) {
        final String execQuery = 'SELECT '+ String.escapeSingleQuotes(inputVal.fieldName) +' FROM '+ String.escapeSingleQuotes(inputVal.objectName) +' WHERE Id IN ('+inputVal.recIds+')';
        System.debug('Query-->'+execQuery);
        return new List<List<sObject>> {Database.query(execQuery)};
    }

}