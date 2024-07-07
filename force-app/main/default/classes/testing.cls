public class testing {
    public void mytesting(){
        CAR__c myCAR = new CAR__c(Name ='Honda');
        insert myCAR;
        system.debug(myCAR);
    }
}