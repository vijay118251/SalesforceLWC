public class JsonPractice {
    public String FirstName;
    public String LastName;
    String json = '{"FirstName":"Deepu","LastName":"Sonu"}';

    public void DeserializeJson(String json)
    {
        JsonPractice jp = (JsonPractice)System.JSON.deserialize(json,JsonPractice.class);
        System.debug(jp);
    }
}