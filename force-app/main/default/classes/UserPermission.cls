public with sharing class UserPermission {
    
    @Auraenabled
    public static String checkUserSettings(String customPermissionName) {
        if(FeatureManagement.checkPermission(customPermissionName)) {
            Id userId = userinfo.getUserId();
			return [SELECT Id, Name FROM User where Id=:userId ]?.Name;
        }
        else {
            /*throw error*/
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage('No Access.');
            throw e;
            //throw new NoAccessException();
        }
    }

}