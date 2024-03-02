public inherited sharing class VehicleSelector {
    
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
    
     public VehicleSelector(Set<FieldGroup> fields) {
        this.fieldSet.addAll(new List<FieldGroup>(fields));
    }
    
    /*  allows the enforceSecurity constructed*/
    public VehicleSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }
    
     /*set setOrderBy clauses */
    public VehicleSelector setOrderBy(String order) {
        this.orderBy = order;
        return this;
    }
    
    /* strip inaccessible method*/
    public VehicleSelector setStripInaccessible(Boolean strip) {
        this.stripInaccessible = strip;
        return this;
        
    }
    
    /*add Field Set*/
    public VehicleSelector addFieldSet(FieldGroup groupType) {
        this.fieldSet.add(groupType);
        return this;
    }
    
    /*dynamicQuery*/
    public List<vehicleInterest__c> dynamicQuery(Set<Id> accountID){
        List<vehicleInterest__c> vhRecs = new List<vehicleInterest__c>();
        final String wher='Account__c IN:accountID';
        final String execQuery=generateQueryString(fieldList(),wher,this.orderBy,this.enforceSecurity);
        system.debug('execQuery-->'+execQuery);
        vhRecs = Database.query(execQuery);
        return this.stripInaccessible ? sanitiseResults(vhRecs): vhRecs;
    }
    
    /*
    * <Name>sanitiseResults</Name>
    * <Summary>To implement the Security</Summary>
    * <Parameter>records - List of sObject</Parameter>
    */
    private static List<vehicleInterest__c> sanitiseResults(List<vehicleInterest__c> records) {
        return Security.stripInaccessible(AccessType.READABLE,records).getRecords();
    }
    
    /*
    * <Name>fieldList</Name>
    * <Summary>To return a list of strings</Summary>
    */
     @TestVisible
    public List<String> fieldList(){
        final List<String> returnList = new List<String>();
        /*Vehicle Interest*/
        if(this.fieldSet.contains(FieldGroup.TESTVEHICLE)) {
            returnList.addAll(getVehicleFields());
        }
        return returnList;
    }
    
    /*getVehicleFields*/
     @TestVisible
    public Set<String> getVehicleFields() {
        return new Set<String> {'Account__c',
            					'X4_Wheel_Drive__c',
            					'Customer__c',
            					'Email__c',
            					'Exterior_Color__c',
            					'Name',
            					'Type__c',
            					'Sunroof__c',
            					'Phone__c',
                                'carStatus__c',
                                'Model__c'
            
        };
    }
    
    /*generateQueryString*/
    public String generateQueryString(List<String> fields,String Wher,String order,Boolean enforceSecurity){
        final String genQuery = 'SELECT '+ String.join(fields,', ')+ 
            					' FROM vehicleInterest__c '+ 'WHERE '+String.escapeSingleQuotes(wher) + 
            					(enforceSecurity? ' WITH SECURITY_ENFORCED' : '') +
            					(String.isNotBlank(order)? ' ORDER BY ' + String.escapeSingleQuotes(order) : '');
        return genQuery;
    }
}