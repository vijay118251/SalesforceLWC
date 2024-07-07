public class apiCallout {
    public static void calloutMethod() {
        Http req = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://sfdcstop.herokuapp.com/blogs');
        request.setMethod('GET');
        HttpResponse response = req.send(request);
        system.debug(response.getStatusCode());
        if(response.getStatusCode()==200) {
            system.debug(response.getBody());
            map<string,object> results = (map<string,object>) JSON.deserializeUntyped(response.getBody());
            system.debug(results);
            final String result = (String) results.get('author');
            List<object> result1 = (List<object>) results.get('blogs');
            for(Object finRes: result1) {
        	System.debug(finRes);
    }		
        }
        
    }

}