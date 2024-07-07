public class OppFlowCreation {
    
    public class AccRequest {
       @InvocableVariable(label='Account ID')
        public string accId;
       @InvocableVariable(label='Account Name')
        public string accName;
       @InvocableVariable(label='Annual Revenue')
        public Double annualRevenue;
    }
    
    @InvocableMethod(label='Create opportunity records')
    public static List<Opportunity> oppCreate(List<AccRequest> accReq) {
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name = accReq[0].accName;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.AccountId =accReq[0].accId;
        opp.Amount = accReq[0].annualRevenue;
        oppList.add(opp);
        insert oppList;
        return oppList;
    }

}