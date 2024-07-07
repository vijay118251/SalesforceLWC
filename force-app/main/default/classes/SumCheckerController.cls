//Generated for Decodeforce programming test
public class SumCheckerController{

	public static boolean isSumGreaterThan100(Integer numb1, Integer numb2){

		Boolean isSumOver100 = false;

		/* Write your logic below */
		Integer sum = numb1 + numb2;
		isSumOver100 = sum > 100 ? true : false;
		return isSumOver100;
	}
}