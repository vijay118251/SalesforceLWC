public class apexCS8 {
    public static void method(string s1, string s2, String s3) {
        map<string,string> mapval = new map<string,string>();
        mapval.put(s1 + s1.countMatches(s3),s2);
        System.debug('mapval->'+mapval);
    }
    
}