// Parser class for GoRestApi
public class GoRestWrapper{
	public Integer id; 
	public String name;
	public String email;
	public String gender;
	public String status;

	// parse method
	public static List<GoRestWrapper> parse(String json) {
		return (List<GoRestWrapper>) System.JSON.deserialize(json, List<GoRestWrapper>.class);
	}
}