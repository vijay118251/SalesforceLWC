trigger Duplicate on Account (before insert,before update) {
    for(account a:trigger.new) {
        list<account> acc=[select id from account where Name=:a.Name];
        if(acc.size()>0) {
            a.Name.adderror('You cannot create duplicate account');
        }
            
    }

}