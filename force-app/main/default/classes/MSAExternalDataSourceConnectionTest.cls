/*
* @author Tcs
* @date 04/08/2022
* @group Vitality
* <Purpose> Test class for MSAExternalDataSourceConnection class</Purpose>
*/
@IsTest
public class MSAExternalDataSourceConnectionTest {

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
        final Account account = new Account (Name = 'Tex', Entity_Number__c = '1248369157',
                                             RecordTypeId = accRecTypId);
        /*insert account*/        
        insert account;
    }

    /*
    * <Name>queryHealthPlanMemeber</Name>
    * <Summary> This method to test api callout for Health Plan Member. </Summary>
    * <Parameter> NA </Parameter>
    */
    @IsTest
    private static void testHealthPlanMemberExternalSelector() {
            // start test
            Test.startTest(); 
            Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator('MemberDetails'));
            Boolean isError = false;
            try {
                   //sync
                   final MSAExternalDataSourceConnection conn = new MSAExternalDataSourceConnection(null);
                   conn.sync();
                   //query
                   final DataSource.QueryContext context = new DataSource.QueryContext();
                    context.tableSelection = new DataSource.TableSelection();
                    context.tableSelection.tableSelected = 'Health Plan Member';
                    context.tableSelection.filter = new DataSource.Filter();
                    context.tableSelection.filter.columnName = 'Health Plan Member';
                    context.tableSelection.filter.columnValue = '1-2-3-4-5';
                    context.tableSelection.filter.type = DataSource.FilterType.EQUALS;
                    final  MSAExternalDataSourceConnection aConn = new MSAExternalDataSourceConnection(null);
                    aConn.query(context);
                    // stop test
                    Test.stopTest();
            } catch(NullPointerException exe) {
                isError = true;
            }
        system.assertEquals(true,isError,'Error occured');
    }
}