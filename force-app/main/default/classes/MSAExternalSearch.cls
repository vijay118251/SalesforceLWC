/**
* @author Tcs
* @date 04/11/2022
* @group Vitality
*<Purpose>class helps to get details of Selected Table.</Purpose>
*/

public class MSAExternalSearch {
    /*The getData method takes in externalId and is passed to the
    getResponse method which helps to create list of rows */
    public static List<Map<String, Object>> getData(DataSource.SearchContext  context) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        /*Query name of the table.*/
         final String tableSelected = context.tableSelections[0].tableSelected;
        /* TableSelection 
        switch on tableSelected {
            when 'Health' {
                if(context.searchPhrase.isNumeric() && context.searchPhrase.length() >= 7) {
                    rows = health.searchData(context);
                }
            }
        }*/
        return rows;
    }
}