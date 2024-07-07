public class CreateAccounts {
	@AuraEnabled
	public static void insertAccounts(Account accountRecObj){
		try {
			System.debug('entered try block');
                insert accountRecObj;
                RecordCount__e event = new RecordCount__e(Success_Count__c=1,Failure_Count__c=0);
        		EventBus.publish(event);
           
		} catch(Exception e){
			System.debug('entered catch block');
            RecordCount__e event = new RecordCount__e(Success_Count__c=0,Failure_Count__c=1);
        	EventBus.publish(event);
		}
	}

	@AuraEnabled
	public static String firePlatformEvents(String inputValue){
		try {
			if(String.isNotBlank(inputValue)) {
				RecordCount__e event = new RecordCount__e(Success_Count__c=1,Failure_Count__c=0);
        		EventBus.publish(event);
			}
           
		} catch(Exception e){
			System.debug('entered catch block');
            RecordCount__e event = new RecordCount__e(Success_Count__c=0,Failure_Count__c=1);
        	EventBus.publish(event);
		}
		return inputValue;
	}

	public class ResponseWrapper{
		@AuraEnabled
		public Boolean isSuccess{get;set;}
		@AuraEnabled
		public String message{get;set;}
	}
}