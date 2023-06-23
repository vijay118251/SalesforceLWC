/**
 * @author Tcs
 * @date 04/06/2022
 * @group Vitality
 *<Purpose>Test class for HealthExclusionExternalSelector </Purpose>
 */
@IsTest
public class HealthPlanMemberExternalSelectorTest {
 
 
    /*
* <Name>setupData</Name>
* <Summary> This method Sets the data for test class. </Summary>
* <Parameter> NA </Parameter>
*/
    @testSetup
    private static void setup() {

        /*Member Record Type*/
        final Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        /*Account*/
        final Account account = new Account (Name = 'Tex',
                                             RecordTypeId = accRecTypId);
        /*insert account*/        
        insert account;
    }

    /*
    * <Name>testHealthPlanMemberExternalSelector</Name>
    * <Summary> This method to test api callout for Health Plan Member. </Summary>
    * <Parameter> NA </Parameter>
    */
    @IsTest
    private static void testHealthPlanMemberExternalSelector() {
            // start test
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator('MemberDetails'));
                   //query
                   final Account acc = [Select Id From Account Limit 1];
                   final DataSource.QueryContext context = new DataSource.QueryContext();
                    context.tableSelection = new DataSource.TableSelection();
                    context.tableSelection.tableSelected = 'Health Plan Member';
                    context.tableSelection.filter = new DataSource.Filter();
                    context.tableSelection.filter.columnName = 'Health Plan Member';
                    context.tableSelection.filter.columnValue = acc.Id;
                    context.tableSelection.filter.type = DataSource.FilterType.EQUALS;
              final DataSource.ColumnSelection selectedColumn = new 
                    DataSource.ColumnSelection();
                    selectedColumn.tableName = 'Health Plan Member';
                    selectedColumn.aggregation = DataSource.QueryAggregation.NONE;
                    context.tableSelection.columnsSelected = new List<DataSource.ColumnSelection>
                    {selectedColumn};
                    HealthPlanMemberExternalSelector.getData(context);
                    // stop test
                    Test.stopTest();
                    System.assertNotEquals(null, HealthPlanMemberExternalSelector.getData(context));
    }
}