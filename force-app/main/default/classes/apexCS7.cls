public class apexCS7 {
    public void method() {
        list<Account> listacc=new list<Account>();
        list<Account> updatelistacc=new list<Account>();
        listacc=[select billingstate from account];
        for(account ac:listacc) {
            if(ac.billingstate=='CA'){
                ac.billingstate='FL';
                updatelistacc.add(ac);
            }
        } update updatelistacc;
    }

}