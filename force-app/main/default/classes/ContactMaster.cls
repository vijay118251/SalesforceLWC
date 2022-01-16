public with sharing class ContactMaster {
    
     @AuraEnabled(cacheable=true)
    public static list<Contact> findContacts(String searchKey){
                String key = '%' + searchKey + '%';
         List<Contact> conlist = [SELECT Id,Name,Phone,Email from Contact WHERE Name LIKE :key LIMIT 10 ];
        return conlist;
    }
}