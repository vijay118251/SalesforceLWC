//Generated for Decodeforce programming test
public class OpportunityCloseDateController{

	public static void setCloseDate(Id opportunityId){

		/* Write your logic below */
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity oppRec = [Select Id,CloseDate,Account.Rating From Opportunity 
                                    Where Id=:opportunityId];
        if(oppRec!=null) {
            if(oppRec.Account.Rating == 'Hot') {
                oppRec.CloseDate = Date.today().addDays(3);
            }

            else if(oppRec.Account.Rating == 'Warm') {
                oppRec.CloseDate = Date.today().addDays(7);
            }

            else {
                oppRec.CloseDate = Date.today().addDays(14);
            }

            oppList.add(oppRec);
        }

        if(!oppList.isEmpty()) {
            update oppList;
        }
        
	}
}