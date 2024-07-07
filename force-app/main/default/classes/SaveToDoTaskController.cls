public with sharing class SaveToDoTaskController {

    @AuraEnabled
    public static String saveToDoTask(string title, Date dueDate){
        try{
            ToDoManager__c toDoManager = new ToDoManager__c();
            toDoManager.Title__c = title;
            toDoManager.Due_Date__c = dueDate;
            insert toDoManager;
            return 'Success';
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<ToDoManager__c> getToDoList(string taskStatus){
        return [SELECT Id, Title__c, Due_Date__c, Status__c from ToDoManager__c WHERE Status__c =: taskStatus
                ORDER BY Due_Date__c];
    }

}