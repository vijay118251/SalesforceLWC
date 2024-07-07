/**
 * @Date    -   28-Feb-2022
 * @Author  -   TCS
 * @Desc    -   UtilityExternalObject class takes in the context variable and helps to generate
 *              externalId which is later used for other methods in the connection classes.
 * */

public class UtilityExternalObject {

    /*  method to get ExtrenalId from context
        This method helps to get external id from the raw context invoked from query method
    */
    public static String getExtrenalId(DataSource.QueryContext context) {
        String externId;
        if(context.tableSelection.filter.columnValue !=null) {
            externId = String.valueOf(context.tableSelection.filter.columnValue);
        }
        else if(context.tableSelection.filter!=null && !context.tableSelection.filter.subfilters.isEmpty()) {
            externId = String.valueOf(context.tableSelection.filter.subfilters[0].columnValue);
        }
        return externId;
    }

    /*  method to get active details
        This method helps to get active information from the array of Object
    */
    public static String getActiveDetails(List<Object> inputObj, String value ,String compare, String checkValue) {
        for(Object obj : inputObj) {
            final String str =  JSON.serialize(obj);
            final Map<String,Object> mapJson = (Map<String,Object>) JSON.deserializeUntyped(str);
            final Boolean isCheckValue = String.isBlank(checkValue) ? true :
                                     mapJson.get(compare) == checkValue;
            if(Boolean.valueOf(mapJson.get('isCurrent')) && isCheckValue) {
                return (String)mapJson.get(value);
            }
        }
        return null;
    }
}