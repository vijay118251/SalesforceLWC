public with sharing class taskController {
    public taskController() {

    }
    @AuraEnabled (cacheable=true)
    public static List<Task__c> getTaskList(){
        return[SELECT Id, Name FROM Task__c];
    }


     /*
    *	Description:- This method is used to insert a new task in Salesforce
    */
    @AuraEnabled
    public static Task__c insertTask(String name) {
        try {
            Task__c task = new Task__c(
                Name = name
            );
            insert task;
            return task;
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
        return null;
    }

     /*
    *	Description:- This method is used to delete a task from Salesforce based on the record id
    */
    @AuraEnabled
    public static Boolean deleteTask(Id recordId) {
        try {
            Database.delete(recordId);
            return true;
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
        return false;
    }

}