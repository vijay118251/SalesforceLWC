public class CreateContacts {
	@AuraEnabled
	public static ResponseWrapper insertContacts(List<Contact> contacts){
		ResponseWrapper response = new ResponseWrapper();
		try{
			System.debug('entered try block');
			insert contacts;
			response.isSuccess = true;
		} catch(Exception e){
			System.debug('entered catch block');
			response.isSuccess = false;
			response.message = e.getMessage();
		}
		return response;
	}

	public class ResponseWrapper{
		@AuraEnabled
		public Boolean isSuccess{get;set;}
		@AuraEnabled
		public String message{get;set;}
	}
}