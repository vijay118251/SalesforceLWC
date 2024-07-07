/*
 * <Purpose> To parse Error response
 */
public class ErrorDetails {

		public Integer errorCode;
		public String errorDateTime;
		public String errorMessage;	
		public String errorDescription;
		public String eid;
		public String service;
		public String instance;
		public String callflow;
		public String path;

     /* class to get error details  */
	public static ErrorDetails parse(String json){
		return (ErrorDetails) System.JSON.deserialize(json, ErrorDetails.class);
	}

}