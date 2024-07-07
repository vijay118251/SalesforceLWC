public class ProductDetails {

    //public List<ProductDetail> prodDetail;

    /*public class ProductDetail {
        public String id;
        public String name;
        public Data data;
    }*/
    	@AuraEnabled
    	public String id;
    	@AuraEnabled
        public String name;
    	@AuraEnabled
        public Data data;

    public class Data {
        @AuraEnabled
        public String color;
        @AuraEnabled
        public String capacity;
    }

    public static List<ProductDetails> parse(String json) {
        return (List<ProductDetails>) System.JSON.deserialize(json, List<ProductDetails>.class);
    }
}