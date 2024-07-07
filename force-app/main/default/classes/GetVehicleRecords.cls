public with sharing class GetVehicleRecords {
    @AuraEnabled(cacheable=true)
    public static List<vehicleInterest__c> getVehicleInterestRecords(){
        List<vehicleInterest__c> vh = [SELECT Id, Name, Type__c, Email__c, Customer__c FROM vehicleInterest__c LIMIT 20];
        return vh;
    }
}