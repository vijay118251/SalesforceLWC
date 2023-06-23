/*
 * <Author> Vijay TCS <Author>
 * Date: 28-Feb-2022
 * <Purpose> Class for ConnectionService </Purpose>
 * This class builds the URL using the request method 
 * and also generate the response error message.
 * <History> * </History>
 */
public  with sharing class ConnectionService {
    /* CREDENTIAL_NAME */
    public final String CREDENTIAL_NAME;
    /* ERROR_MESSAGE */
    public final static String ERROR_MESSAGE= 'errorMessage';
    /* PRODUCT_SERVICE */
    public final String PRODUCT_SERVICE;


    /*Protected method constructor buildUrl*/
    public ConnectionService(String service,String apiType, ProductHouse prodhouse) {
        CREDENTIAL_NAME = service;
        PRODUCT_SERVICE = prodhouse.Name().toLowerCase('en')+'/'+ apiType+'/';
    }

    /*Protected method constructor buildUrl*/
    public ConnectionService(String service,String apiType) {
        CREDENTIAL_NAME = service;
        PRODUCT_SERVICE =  apiType;
    }

    /* Protected method constructor buildUrl
    The buildUrl method takes the endpoint to build 
    the Url which is used by the buildRequest method
    */
    private String buildUrl(String endpoint) {
        return !Test.isRunningTest() ? 'callout:' + CREDENTIAL_NAME + '/' + PRODUCT_SERVICE + endpoint
            : 'https://callout.' + CREDENTIAL_NAME + '.com/' + endpoint;
    }


    /* Protected method constructor buildRequest
    The buildRequest methods takes in 4 parameters which 
    helps to build the HttpRequest 
    */
    private HttpRequest buildRequest(String endpoint, String method, String body, Map < String, String > header) {
        final String uri = this.buildUrl(endpoint);
        final HttpRequest req = new HttpRequest();
        req.setEndpoint(uri);
        req.setMethod(method);
        if (body != null) {
            req.setBody(body);
        }
        if (header != null) {
            for (String key: header.keySet()) {
                req.setHeader(key, header.get(key));
            }
        }
        return req;
    }


    /* Constructor 
    The get method takes in the Https Request and builds up the response
    */
    public String get(String endpoint) {
        final string method = 'GET';
        String response;
        try {
            final HttpRequest req = this.buildRequest(endpoint, method, null, null);
            final HttpResponse res = new Http().send(req);
            // build JSON with error information if status <> 200
            response = res.getBody();
            // create a generic http error
            if (res.getStatusCode() != 200 && (response == null || response.contains(ERROR_MESSAGE))) {
                response = this.createJsonError(res);
            }
        } catch (Exception e) {
            final String errorMessage = e.getMessage().replace('"', '\'');
            response = '{"error":{"' + ERROR_MESSAGE+ '":"' + errorMessage + '"}}';
        }
        return response;
    }
    
     /* Constructor 
    The get method takes in the Https Request and builds up the response
    */
    public String get(String endpoint, Map<String, String> headers) {
        final string method = 'GET';
        String response;
        try {
            final HttpRequest req = this.buildRequest(endpoint, method, null, headers);
            final HttpResponse res = new Http().send(req);
            // build JSON with error information if status <> 200
            response = res.getBody();
            // create a generic http error
            if (res.getStatusCode() != 200 && (response == null || response.contains(ERROR_MESSAGE))) {
                response = this.createJsonError(res);
            }
        } catch (Exception e) {
            final String errorMessage = e.getMessage().replace('"', '\'');
            response = '{"error":{"' + ERROR_MESSAGE+ '":"' + errorMessage + '"}}';
        }
        return response;
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