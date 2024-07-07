public class Address {   
    public static void ShippingToBillingAddress(List<Account> newAccounts) {
    for (Account acc : newAccounts) {
      acc.BillingStreet = acc.ShippingStreet;
      acc.BillingCity = acc.ShippingCity;
      acc.BillingState = acc.ShippingState;
      acc.BillingPostalCode = acc.ShippingPostalCode;
      acc.BillingCountry = acc.ShippingCountry;
    }
  }
    public static void HelloWorld(List<Account> AccountList){
        for(Account newAccount : AccountList){
            if(newAccount.Hello__c == null){
            	newAccount.Hello__c = 'World';
            }
        }    
    }
 
}