public class datatypesomu {
    public void methodsomu(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<2;i++) {
            Account acc = new Account();
            acc.name='Test'+i;
            accList.add(acc);
        }
        insert accList;
    }
    
    public void MapMethod() {
        Map<String,String> strMap = new Map<String,String>();
       	strMap.put('1','First');
        strMap.put('2','Second');
        system.debug(strMap);
    }
    
    public void tstMethod() {
        List<Account> accList = [select ID, Name,(Select Id,Firstname,Lastname from contacts) from Account where Name = 'Rohi'];
        List<contact> conList= [Select Id,Firstname,Lastname,Account.Name FROM Contact];
        system.debug('Acc List Query'+accList);
        system.debug('Con List Query'+conList);
    }
    
    public void ContactCreation(){
            Account acc = new Account();
            acc.name='AccRec';
        	insert acc;
        	Contact con = new Contact();
            con.FirstName='AccRec First';
        	con.LastName='AccRec Last';
       		con.AccountId=acc.id;
            insert con;
    }
}