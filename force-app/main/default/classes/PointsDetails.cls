/*
 * <Purpose> To parse a response
 */
public class PointsDetails {

    //public List<PointDetail> pointDetail { get; set; }

	//public class PointDetail {
        /* vitalityPlanId */
        @AuraEnabled
		public String vitalityPlanId { get; set; }
        /* planType */
        @AuraEnabled
		public String planType { get; set; }
        /* planCode */	
        @AuraEnabled
		public String planCode { get; set; }
        /* planStartDate */
        @AuraEnabled	
		public String planStartDate { get; set; }
        /* previousRenewalDate */
        @AuraEnabled
		public String previousRenewalDate { get; set; }
        /* renewalDate */
        @AuraEnabled
		public String renewalDate { get; set; }
        /* familyMembers */
        @AuraEnabled
		public FamilyMembers[] familyMembers { get; set; }
	//}
	public class FamilyMembers {
        /* entityId */
        @AuraEnabled
		public String entityId;	
        /* name */
        @AuraEnabled
		public Name name;
        /* dateOfBirth */
        @AuraEnabled
		public String dateOfBirth;	
        /* roleCode */
        @AuraEnabled
		public String roleCode;	
        /* roleDescription */
        @AuraEnabled
		public String roleDescription;
        /* age */
        @AuraEnabled
		public Integer age;	
        /* gender */
        @AuraEnabled
		public String gender;
	}
	Public class Name {
        /* title */
        @AuraEnabled
		public String title;
        /* forename */
        @AuraEnabled
		public String forename;
        /* surname */
        @AuraEnabled
		public String surname;
	}

    /* class to get points details 
	public static PointsDetails parse(String json){
        PointsDetails details = new PointsDetails();
        String jsonStr;
        jsonStr = json.replace('family-members','familyMembers');
        if(jsonStr.contains('errorMessage')) {
         details = (PointsDetails) System.JSON.deserialize(jsonStr,PointsDetails.class); 
        } else {
		details.pointDetail = (List<PointsDetails.PointDetail>) System.JSON.deserialize(jsonStr, List<PointsDetails.PointDetail>.class);
        }
        return details;
	} */

     /* class to get points details */
	public static List<PointsDetails> parse2(String json){
        List<PointsDetails> details = new List<PointsDetails>();
        String jsonStr;
        jsonStr = json.replace('family-members','familyMembers');
		details = (List<PointsDetails>) System.JSON.deserialize(jsonStr, List<PointsDetails>.class);
        return details;
	} 

}