trigger Customer5Triggers on Customer__c (after insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            list<AccountTeamMember> members=new list<AccountTeamMember>();
            for(Customer__c cust:trigger.new) {
                if(cust.Account__c!=null) {
                    AccountTeamMember member=new AccountTeamMember();
                    member.AccountID=cust.Account__c;
                    member.TeamMemberRole='Account Manager';
                    member.UserID=cust.Account_Manager__c;
                    members.add(member);
                }
            }
            try {
                insert members;
            }
            catch(Exception e) {
                system.debug('Insert of members is aborted due to this error'+e.getMessage());
            }
        }
    }
    
}