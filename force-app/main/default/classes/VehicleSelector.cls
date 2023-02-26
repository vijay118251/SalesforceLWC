public class VehicleSelector {
    
    /*Enforce Security*/
    @TestVisible
    public boolean enforceSecurity = false;
    /*Enforce Security*/
    @TestVisible
    public boolean stripInaccessible = false;
     /* Order By*/
    public String orderBy = null;
    /* Field Set */
    public List<FieldGroup> fieldSet =  new List<FieldGroup>();
    /* Enum Field Group*/
    public enum FieldGroup { TESTVEHICLE }
    
     /*
* <Name>Constructor</Name>
* <Summary>Uses the default values for the fields to return</Summary>
*/
    public VehicleSelector(){
        this.fieldSet.add(FieldGroup.TESTVEHICLE);
    }
    
    /*  allows the enforceSecurity constructed*/
    public Boolean setEnforceSecurity(Boolean enforce) {
        return this.enforceSecurity = enforce;
    }
    
    /* strip inaccessible method*/
    public Boolean setStripInaccessible(Boolean strip) {
        return this.stripInaccessible = strip;
        
    }
    
    /*dynamicQuery*/
    public List<vehicleInterest__c> dynamicQuery(Set<Id> accountID){
        List<vehicleInterest__c> vhRecs = new List<vehicleInterest__c>();
        final String wher='Account__c IN:accountID';
        final String execQuery=generateQueryString(fieldList(),wher,this.orderBy,this.enforceSecurity);
        system.debug('execQuery-->'+execQuery);
        vhRecs = Database.query(execQuery);
        return vhRecs;
    }
    
    /*
    * <Name>fieldList</Name>
    * <Summary>To return a list of strings</Summary>
    */
    public List<String> fieldList(){
        final List<String> returnList = new List<String>();
        /*Vehicle Interest*/
        if(this.fieldSet.contains(FieldGroup.TESTVEHICLE)) {
            returnList.addAll(getVehicleFields());
        }
        return returnList;
    }
    
    /*getVehicleFields*/
    public Set<String> getVehicleFields() {
        return new Set<String> {'Account__c',
            					'X4_Wheel_Drive__c',
            					'Customer__c',
            					'Email__c',
            					'Exterior_Color__c',
            					'Name',
            					'Type__c',
            					'Sunroof__c',
            					'Phone__c'
            
        };
    }
    
    /*generateQueryString*/
    public String generateQueryString(List<String> fields,String Wher,String order,Boolean enforceSecurity){
        final String genQuery = 'SELECT '+ String.join(fields,', ')+ 
            					' FROM vehicleInterest__c '+ 'WHERE '+String.escapeSingleQuotes(wher) + 
            					(enforceSecurity? ' WITH SECURITY_ENFORCED' : '');
        return genQuery;
    }
}