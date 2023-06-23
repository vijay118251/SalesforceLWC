/**
 * @Date     :    08-Mar-2022
 * @Author   :    Vijay 
 * @Desc     :    MSAExternalSelector class helps to get 
 * details of Selected Table.
 * */

public class MSAExternalSelector {

    /*The getData method takes in externalId and is passed to the 
    getResponse method which helps to create list of rows */
    public static List<Map<String, Object>> getData(DataSource.QueryContext  context) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
         /*Query name of the table.*/
        final String tableSelected = context.tableSelection.tableSelected;

        /* TableSelection*/
        switch on tableSelected {
            when 'Health Plan Member' {
                rows = HealthPlanMemberExternalSelector.getData(context);
            }
        }
        /* return list of rows */
        return rows;
    }
}