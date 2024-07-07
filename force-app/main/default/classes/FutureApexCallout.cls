public class FutureApexCallout {
    
    @future(callout=true)
    public static void callout(List<Id> accId) {
        if(accId.size() > 0) {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('endpoint');
            HttpResponse response = http.send(req);
            if(response.getStatusCode()==200) {
                system.debug('Success');
            }
            
        }
        
    }

}