//Generated for Decodeforce programming test
public class accountReplaceTextController{

	public static String replaceHtmlChars(String accountDesc){

		String replacedText;

		/* Write your logic below */
        replacedText = accountDesc.replaceAll('<br>',',');

		return replacedText;
	}
}