/**
 * @author Tcs
 * @date 04/06/2022
 * @group Vitality
 *<Purpose>Test class for ConnectionAbstractService </Purpose>
 */

@IsTest
public with sharing class ConnectionServiceTest {
    /* MEMBERS */
    static final String MEMBERS = 'members/';
    /* ENDPOINT */
    static final String ENDPOINT = 'servicing/1/plans/';
    /* EXPECTEDVALUE */
    static final String EXPECTEDVALUE = '{"example":"test"}';
    /* SERVICE */
    static final String SERVICE = 'MSA_API';
    /* API_TYPE */
    static final String API_TYPE = 'integration-experience';
    /* PROD_HOUSE */
    static final ProductHouse PROD_HOUSE = ProductHouse.VITALITY;

    @IsTest
    private static void testMsaCache() {
        Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator('MemberDetails'));
       // ConnectionService.Response res;
        //ConnectionService.get res;
        Test.startTest();
        final String res = new ConnectionService(SERVICE,API_TYPE,PROD_HOUSE).get('member');
        Test.stopTest();
        system.assertNotEquals(null,res);
    }
    /* This method is use to test the Federation in Header Parameter */
    @IsTest
    private static void testMsaCacheheader() {
        Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator('MemberDetails'));
        //Start Test
        Test.startTest();
        final String res = new ConnectionService(SERVICE,API_TYPE,PROD_HOUSE).get('member',new Map<String, String>{'userId' => 'c60981'});
        //Stop Test
        Test.stopTest();
        system.assertNotEquals(null,res);
    } 

    @IsTest
    private static void testMsaErrorResponse() {
        Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator('error'));
        // start test
        Test.startTest();
        final String res = new ConnectionService(SERVICE,API_TYPE,PROD_HOUSE).get('error');
        // stop test
        Test.stopTest();
        final boolean isError = res.contains('error');
        System.assert(true, isError);
    }

    @IsTest
    private static void testCatchMethod() {
        Test.setMock(HttpCalloutMock.class, new MockExternalObjResponseGenerator(null));
        // start test
        Test.startTest();
        final String res = new ConnectionService(SERVICE,API_TYPE,PROD_HOUSE).get(null);
        //stop test
        Test.stopTest();
        system.assertNotEquals(null,res);
    }
}