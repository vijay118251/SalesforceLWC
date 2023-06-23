/**
 * @author Tcs
 * @date 04/08/2022
 * @group Vitality
 *<Purpose>Test class for MSAExternalDataSourceProvider </Purpose>
 */

@IsTest
public class MSAExternalDataSourceProviderTest {
    /*ERRORJSON*/
   final static String ERRORJSON = '{ "error": {\"errorCode\": 500, \"errorDateTime\":\"errorDateTime\", \"errorMessage\":\"errorMessage\", \"errorDescription\":\"errorDescription\", \"unrecognizedProperty\":\"unrecognizedProperty\"} }';
    @testSetup
    private static void setupData() {
        /*Account RecordType*/
        final Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        /*Account*/
        final Account account = new Account (Name = 'Alex');
        /*insert account*/
        insert account;
    }

     @IsTest
    private static void testExternalSelector() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        DataSource.ConnectionParams context = new DataSource.ConnectionParams();
        final MSAExternalDataSourceProvider externalSelector = new MSAExternalDataSourceProvider();
        Test.startTest();
        externalSelector.getAuthenticationCapabilities();
        externalSelector.getCapabilities();
        externalSelector.getConnection(context);
        Test.stopTest();
        system.assertNotEquals(null, externalSelector.getConnection(context));
    }
}