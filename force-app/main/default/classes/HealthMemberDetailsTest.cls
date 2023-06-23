/**
 * @author Tcs
 * @date 04/06/2022
 * @group Vitality
 *<Purpose>Test class for HealthMemberDetails </Purpose>
 */
@IsTest
public class HealthMemberDetailsTest {
    /*<Method> This method is used to test the class with response </Method>
     *<Purpose>This test method should give 100% coverage</Purpose>
     */
    static testMethod void testParse() {
        final String apiResponse = '{"memberId":"1739551","entityNumber":"1248369157","title":"Mr","forename":"MaBCFKDHLBGJ","surname":"StBCFKDHLBGJ","gender":"Male","dateOfBirth":"1993-12-31","contactDetails":{"addresses":[{"line1":"Marshall Point","line2":"4 Richmond Gardens","line4":"BOURNEMOUTH","postcode":"BH1 1JD","startDate":"2021-02-15","isCurrent":"true","audit":{"createdBy":"TDM","createdDate":"2021-08-20T05:12:33.000Z","lastUpdatedBy":"TDM","lastUpdatedDate":"2021-08-20T05:12:33.000Z"}}],"emailAddresses":[{"emailAddress":"anon@anon.com","startDate":"2021-08-20","isCurrent":"true","audit":{"createdBy":"TDM","createdDate":"2021-08-20T05:12:33.000Z","lastUpdatedBy":"TDM","lastUpdatedDate":"2021-08-20T05:12:33.000Z"}}]},"products":[{"membershipNumber":100001956259,"planNumber":"52811181","businessType":"Health","roleCode":"PTR","roleDescription":"Partner","coverStartDate":"2021-07-21","dateOfJoining":"2021-07-21","status":"Active","parentMembershipNumber":100001810093,"planStartDate":"2021-02-15","renewalDate":"2022-02-15","previousRenewalDate":"2021-02-15","productDetails":{"productCode":"EPH","productName":"Personal Healthcare"},"UnderwritingType":{"underwritingCode":"FMU","underwritingDescription":"Full Medical Underwriting"},"FamilyStatus":{"statusCode":"F02","statusDescription":"Couple"}}]}';
        // start test
        Test.startTest();
        HealthMemberDetails.parse(apiResponse);
        // stop test
        Test.stopTest();
        system.assertNotEquals(null, HealthMemberDetails.parse(apiResponse));
    }

}