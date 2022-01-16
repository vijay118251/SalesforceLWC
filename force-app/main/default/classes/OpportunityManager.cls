public class OpportunityManager {
     @AuraEnabled
    public static list<Opportunity> fetchOpportunityDetails(string oppName){
        if(string.isNotBlank(oppName)){
            string searchOpp ='%'+oppName+'%';
            return [SELECT Id,Account.Name,Name,StageName, CloseDate
                    FROM Opportunity
                    where Name like :searchOpp];
        } 
        else{
            return NULL;
        }   
    }
    @AuraEnabled
    public static string closeOpportunity(string opportunityId){
        string message;
        try{
            opportunity opp = new opportunity(Id=opportunityId);
            opp.StageName='Closed Won';
            update opp;
            message = 'Success';
        }   
        catch(Exception ex){
            message = ex.getMessage();
        } 
        return message;
    }

}