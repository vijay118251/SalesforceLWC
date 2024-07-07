public class GorestWrapper {
    public List<User> users {get; set;}

    public class User{
        public String id {get;set;}
        public String name {get;set;}
        public String email {get;set;}
        public String gender {get;set;}
        public String status {get;set;}
    }

    public static GorestWrapper ParseResponse(String json){
        GorestWrapper details = new GorestWrapper();
        details.users = new List<GorestWrapper.User>();
        if(json.contains('errorMessage')) {
            details = (GorestWrapper) System.JSON.deserialize(json,GorestWrapper.class);
        } else {
            details.users = (List<GorestWrapper.User>) System.JSON.deserialize(json,List<GorestWrapper.User>.class);
        }
        return details;
    }
}