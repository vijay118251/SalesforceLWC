public class ExceptionHandlings {
    // ****custom exception******
    @InvocableMethod
    public static void myMethod(List<Account> scope) {
        List<Account> acclist = new list<account>();
        try {
            for(Account ac : scope) {
                if(ac.billingstate=='AB') {
                    throw new MyException();
                }
                else {
                    ac.billingstate='FL';
                } acclist.add(ac);
            }
            update acclist;
        }
        catch(MyException n){
            system.debug('Billing State is invalid');
        }
    }

}