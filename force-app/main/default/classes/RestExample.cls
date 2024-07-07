public class RestExample {
    public void callout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://gorest.co.in/public/v2/users');
        request.setMethod('GET');
        HttpResponse response  = new HttpResponse();
        response = http.send(request);

        if(response.getStatusCode() == 200){
            System.debug('Success');
            System.debug(response.getBody());
            List<Object> obj = new List<Object>();
            GorestWrapper details = GorestWrapper.ParseResponse(response.getBody());
            System.debug('details-->'+details.users);

            

            Map<String,Object> users = new Map<String,Object>();
            for(GorestWrapper.User user : details.users){
                users.put(user.name, user);
            }
            System.debug('usersMap-->'+users);
            System.debug('Sudeva Shah-->'+users.get('Sudeva Shah'));

        }

    }
    
}