public class AccountManager {
    /*  @AuraEnabled (cacheable=true)
      public static List <Account> getAccounts() {
        return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone, Rating, Website, AnnualRevenue
                FROM Account ORDER BY createdDate ASC LIMIT 25];
      }*/
    
     @AuraEnabled
    public static List <Account> fetchAccountDetails(String accName){
        if(string.isNotBlank(accName)){
            string searchName ='%'+accName+'%';
            return [Select Id, name, Industry, Type, NumberOfEmployees, TickerSymbol, Phone, Rating, Website, 
                    AnnualRevenue,(select Department,FirstName, LastName from Contacts)
                FROM Account where name like :searchName];
        } 
        else{
            return NULL;
        }  
  }
}