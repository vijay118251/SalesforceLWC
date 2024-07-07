public class ContactCreation {
    @InvocableMethod(label='Create Contact From Account')
    public static void createContactFromAcc(List<Account> accRec) {
        List<Contact> conList = new List<Contact>();
        for(Account acc:accRec) {
            Contact con = new Contact();
            con.FirstName = 'Apex Invocable';
            con.LastName = 'Action';
            con.Email = 'flow@gmail.com';
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
    }

}