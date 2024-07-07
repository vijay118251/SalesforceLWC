public class dynamicQuery {
    public static void method() {
        string fields = '';
        //Grab the SObjectType
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Opportunity');
        System.debug('objType=='+objType);
        
        //Grab the map of fields from the DescribeSObject
        //Set<String> fields = objType.getDescribe().fields.getMap().keySet();
        //System.debug('fields=='+fields);
        Set<String> fieldSet = Schema.SObjectType.Opportunity.fields.getMap().keySet();
        System.debug('fields=='+fieldSet);
        
        Map<String,Schema.SObjectField> fieldMap = Schema.SObjectType.Opportunity.fields.getMap();
        System.debug('fiedsOpportunity=='+fields);
        
        for(String field : fieldMap.keySet())
            
        {
            
            fields += field + ', ';
        }
        System.debug('fiedsOpportunity=='+fields);
    }
    
}