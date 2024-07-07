/* Author: Vijay M
* Rest Callout - GoRestAPI
*/
public class GoRestAPIService {
    public static final string baseUrl='https://gorest.co.in';
    public static final string operation='GET'; 
    private static string endpoint = '/public/v2/users';
    
    //wrapper
    public class RestWrapper {
        public List<GoRestWrapper> details{get;set;}
    }
    
    // Method - userCallout
    public static RestWrapper userCallout(){
        final RestWrapper wrap = new RestWrapper();
        /*Connection Service*/ 
    	final ConnectionService CONNECTIONSERVICE = 
            new ConnectionService(baseUrl,operation);
        final String FULL_ENDPOINT = baseUrl+endpoint;
        String response = CONNECTIONSERVICE.get(FULL_ENDPOINT);
            // Parse the JSON response
            List<GoRestWrapper> respList = GoRestWrapper.parse(response);
            if(!respList.isEmpty()) {
                wrap.details=respList;
                populateUserRow(respList);
                displayUserRow(wrap);
            }
            system.debug('wrap'+wrap);
         return wrap;
        }
    
    // Display Response in map format
    public static List<Map<String, Object>> populateUserRow(List<GoRestWrapper> userRows){
        system.debug('userRows'+userRows);
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        for(GoRestWrapper user :userRows){
            Map<String, Object> row = new Map<String, Object>();
            row.put('Id',user.id);
            row.put('Name',user.name);
            row.put('Email',user.email);
            row.put('Gender',user.gender);
        	row.put('Status',user.status);
            row.put('Url',baseUrl+endpoint);
            rows.add(row);
            system.debug('rows'+rows);
        }
        return rows;
    }
    
    // Display Response in map format
    public static List<Map<String, Object>> displayUserRow(RestWrapper userRows){
        system.debug('userRows'+userRows);
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        for(GoRestWrapper user :userRows.details){
            Map<String, Object> row = new Map<String, Object>();
            row.put('Id',user.id);
            row.put('Name',user.name);
            row.put('Email',user.email);
            row.put('Gender',user.gender);
        	row.put('Status',user.status);
            row.put('Url',baseUrl+endpoint);
            rows.add(row);
            system.debug('rows'+rows);
        }
        return rows;
    }
    
    private GoRestAPIService(){
        
    }
    
}