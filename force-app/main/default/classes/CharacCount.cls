public with sharing class CharacCount {
    private static String highestChar;
    public static void countMethod() {
        String str='abcdabcecf';
        Map<String,Integer> strMap = new Map<String,Integer>();
        List<String> StrList = str.split('');
        for(String st1:StrList) {
            if(strMap.containsKey(st1)) {
                Integer count = strMap.get(st1);
                count++;
                strMap.put(st1,count);
            }
            else {
                strMap.put(st1,1);
            } 
        }
        highestChar=findChar(strMap);
        System.debug('highestChar-->'+highestChar);
    }
        
        public static String findChar(Map<String,Integer> strMap) {
            String highestChar;
            Integer max=0;
            for(String st2:strMap.keySet()) {
                Integer cnt =strMap.get(st2);
                if(cnt>max) {
                    max=cnt;
                    highestChar=st2;
                }   
            }
            System.debug('highestChar-->'+highestChar);
            return highestChar;
        }  
}