//Generated for Decodeforce programming test
public class OrderReturnController{

	public static Boolean checkOrderWithin30Days(String orderNumber){

		boolean isOrderWithIn30Days = false;

		/* Write your logic below */
        Order ordRec = [Select OrderNumber,Sold_Date__c From Order where OrderNumber=:orderNumber];
        Date myDate = ordRec.Sold_Date__c;
        Date todayDate = Date.today();
        Integer daysDifference = todayDate.daysBetween(myDate);
        isOrderWithIn30Days = daysDifference < 30 ? true : false;
		return isOrderWithIn30Days;
	}
}