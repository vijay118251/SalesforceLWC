/**
 * @author Tcs
 * @date 04/08/2022
 * @group Vitality
 *<Purpose> Test class for MockExternalObjResponseGenerator </Purpose>
 */

@isTest
global class MockExternalObjResponseGenerator implements HttpCalloutMock {
    /* API TYPE*/
    private final String apiType;
    /* ERROR_TEXT */
    public final static String ERROR_TEXT = 'error';
    /*Constructor*/
    public MockExternalObjResponseGenerator(String apiType) {
        this.apiType = apiType;
    }

    /*
     * Implement this interface method
     */
    global HTTPResponse respond(HTTPRequest req) {
        // Create a mock response
        final HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if(this.apiType == ERROR_TEXT) {
            //set status code
            res.setStatusCode(500);
            //set body
            res.setBody(generateErrorResponse(res));
        } else {
            //set status code
            res.setStatusCode(200);
            //set body
            res.setBody(generateMockResponse(this.apiType));            
        }
        return res;
    }

    /*
     * <Name>generateMockResponse</Name>
     * <Summary>get mock response from static resource</Summary>
     * <Parameter> file name</Parameter>
     */
    private String generateMockResponse(string fileName) {
        final StaticResourceSelector staRes = new StaticResourceSelector();
        final StaticResource response = staRes.selectByName(fileName);
        return response.Body.toString();
    }

    /*
     * <Name>generateMockResponse</Name>
     * <Summary>get mock response from static resource</Summary>
     * <Parameter> file name</Parameter>
     */
    private String generateErrorResponse(HttpResponse res) {
        return '{"error":{' +
                '"errorCode": "' +
                res.getStatusCode() +
                '", ' +
                '"errorDateTime": "' +
                System.now() +
                '", ' +
                '"errorMessage":"Error code: ' +
                res.getStatusCode() +
                ' Error message: ' +
                res.getStatus() +
                '"' +
                '}' +
               '}';
    }
}