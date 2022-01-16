public class apexCS6 {
    public void method(Integer no) {
        list<Account> listacc = new list<Account>();
        for(Integer i=1; i<=no; i++) {
            account ac=new account();
            ac.Name = 'test' + i;
            listacc.add(ac);      
        }
        insert listacc;
    }
    
}