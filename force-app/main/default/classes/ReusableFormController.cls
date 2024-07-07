public with sharing class ReusableFormController {
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldDetails(String objectAPiName) {
        system.debug('objectAPiName-->'+ objectAPiName);
        Form_Fields__mdt formFields = [SELECT Fields_APIs__c FROM Form_Fields__mdt WHERE DeveloperName=: objectAPiName];
        system.debug('formFields-->'+ formFields);
        List<String> fieldList = formFields.Fields_APIs__c.split(',');
        system.debug('fieldList-->'+ fieldList);
        return fieldList;
    }
}