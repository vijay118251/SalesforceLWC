public with sharing class EmployeeDetails {
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
	public List<EmployeeData>  data { get; set; }
    @AuraEnabled
	public String message { get; set; }	//Successfully! Record has been fetched.
	
    public class EmployeeData {
        @AuraEnabled
		public Integer id;
        @AuraEnabled
		public String employeeName;
        @AuraEnabled
		public Integer employeeSalary;	
        @AuraEnabled
		public Integer employeeAge;
        @AuraEnabled	
		public String profileImage;
	}

	public static EmployeeDetails parse(String json){
        String jsonStr;
        jsonStr = json.replace('employee_name','employeeName')
                      .replace('employee_salary','employeeSalary')
                      .replace('employee_age','employeeAge')
                      .replace('profile_image','profileImage');
		return (EmployeeDetails) System.JSON.deserialize(jsonStr, EmployeeDetails.class);
	}
}