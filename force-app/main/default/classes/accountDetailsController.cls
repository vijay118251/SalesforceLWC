//Generated for Decodeforce programming test
public class accountDetailsController{

	public static List<String> convertMultiPickList(String accountDesc){

		List<String> convertedList;

		/* Write your logic below */
        if(String.isNotBlank(accountDesc)) {
            convertedList = accountDesc.split(';');
        }
		return convertedList;
	}
}