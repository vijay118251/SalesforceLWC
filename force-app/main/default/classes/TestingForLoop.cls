public with sharing class TestingForLoop {
    
    public static void accMethod() {
       string str='aabbbccde';
       Integer cnt= str.length();
        for(Integer i=cnt; i>0; i--) {
            system.debug(i);
        }
    }

}