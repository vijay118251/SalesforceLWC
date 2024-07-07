/*
 * <Author> Vijay TCS <Author>
 * <Purpose> Class for ConnectionService </Purpose>
 * This class builds the URL using the request method 
 * and also generate the response error message.
*/
public with sharing class ConnectionServices {
	/* BASE_URL */
    public final String BASE_URL;
    /* OPERATION */
    public static final string OPERATION; 
    /* END_POINT */
    private static string END_POINT;
    /* ERROR_MESSAGE */
    public final static String ERROR_MESSAGE= 'errorMessage';
    
    /*Protected method constructor buildUrl*/
    public ConnectionServices(String url,String operation,String endPoint) {
        BASE_URL = url;
        OPERATION = operation;
        END_POINT = endPoint;
        
    }
    
     /* Constructor 
    The get method takes in the Https Request and builds up the response
    */
    public String get(String endpoint) {
        final string method = 'GET';
        String response;
        try {
            final HttpRequest req = this.buildRequest(endpoint, method);
            final HttpResponse res = new Http().send(req);
            // build JSON with error information if status <> 200
            response = res.getBody();
            // create a generic http error
            if (res.getStatusCode() != 200 || response.contains(ERROR_MESSAGE)) {
                response = this.createJsonError(res);
            }
        } catch (Exception e) {
            final String errorMessage = e.getMessage().replace('"', '\'');
            response = '{"error":{"' + ERROR_MESSAGE+ '":"' + errorMessage + '"}}';
        }
        return response;
    }
    
    /* The buildRequest methods 
    helps to build the HttpRequest 
    */
    private HttpRequest buildRequest(String endpoint, String method) {
        //final String uri = this.buildUrl(endpoint);
        final String uri = endpoint;
        final HttpRequest req = new HttpRequest();
        req.setEndpoint(uri);
        req.setMethod(method);
        return req;
    }
    
    private String buildUrl(String endpoint) {
        return BASE_URL + END_POINT;
    }
    
    /* Protected method constructor createJsonError
    The createJsonError method build up the error message
    depending upon the response.
    */
    @TestVisible
    private String createJsonError(HttpResponse res) {
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