public class MetadataCarPageSelector {
    /*Enforce Security*/
    @TestVisible
    private Boolean enforceSecurity = false;
    /*Order By*/
    private String orderBy = null;
    /*Field Set*/
    private Final List<FieldGroup> fieldSet = new List<FieldGroup>();
    /*Enum Field Group*/
    public enum FieldGroup { CARMODEL, CARPAGE }
    
    /*
    * <Name>Constructor</Name>
    * <Summary>Uses the default values for the fields to return</Summary>
    */
    public MetadataCarPageSelector() {
        this.fieldSet.add(FieldGroup.CARMODEL);
        this.fieldSet.add(FieldGroup.CARPAGE);
    }

    /*
    * <Name>Constructor</Name>
    * <Summary>allows the configuration</Summary>
    * <Parameters>Boolean enforce,Boolean strip,String order</Parameters>
    */
    public MetadataCarPageSelector(Boolean enforce, String order) {
        this.enforceSecurity = enforce;
        this.orderBy = order;
    }
    
    /*  allows the enforceSecurity constructed*/
    public MetadataCarPageSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }

     /*
    * <Name>generateQueryString</Name>
    * <Summary>Generate a SOQL query in a database query</Summary>
    * <Parameter>fields, Where, Order and enforceSecurity</Parameter>
    */
    private String generateQueryString(List<String> fields, String wher) {
        final String genQuery = 'SELECT ' + String.join(fields,', ')
            +' FROM BmwCarModel__mdt'
            +' WHERE ' + String.escapeSingleQuotes(wher)
            + (this.enforceSecurity ? ' WITH SECURITY_ENFORCED ': '')
            + (String.isNotBlank(this.orderBy) ? ' ORDER BY ' + String.escapeSingleQuotes(this.orderBy) : '');
        return genQuery;
    }

     /*
    * <Name>selectIconByPage</Name>
    * <Summary>Generate a SOQL query in a database query</Summary>
    * <Parameter>page is neccasry</Parameter>
    */
    public Map<String,BmwCarModel__mdt> selectCarPage(String pageName) {
        Map<String,BmwCarModel__mdt> carDetails = new Map<String,BmwCarModel__mdt>();
        final String wher = 'metadataCar__r.DeveloperName =: pageName';
        final String execQuery = generateQueryString(fieldList(), wher);
        System.debug('execQuery-->'+execQuery);
        final List<BmwCarModel__mdt> carModels = Database.query(execQuery);
        System.debug('Meta Reponse-->'+carModels);
        carDetails = setCarGroup(carModels);
        return carDetails;
    }

    public Map<String,BmwCarModel__mdt> setCarGroup(List<BmwCarModel__mdt> carModels) {
        final Map<String,BmwCarModel__mdt> carGroups = new Map<String,BmwCarModel__mdt>();
        for(BmwCarModel__mdt model:carModels) {
            final string pageName = model.Id;
            carGroups.put(pageName,model);
            System.debug('Map Reponse-->'+carGroups);
        }
        System.debug('Final Map Reponse-->'+carGroups);
        return carGroups;
    }

    
    /*
    * <Name>fieldList</Name>
    * <Summary>To return a list of strings</Summary>
    */
    private List<String> fieldList() {
        final List<String> returnList = new List<String>();
        /*ICON*/
        if(this.fieldSet.contains(FieldGroup.CARMODEL)) {
            returnList.addAll(selectCar());
        }
        if(this.fieldSet.contains(FieldGroup.CARPAGE)) {
            returnList.addAll(selectCarPage());
        }
        return returnList;
    }
    
    /*
    * <Name>Icon</Name>
    * <Summary>To return a default set of strings</Summary>
    */
    @TestVisible
    private static Set<String> selectCar() {
        return new Set<String>{
            'Id',
            'DeveloperName',
            'MasterLabel',
            'carLogo__c',
            'carName__c',
            'fuelType__c',
            'Mileage__c',
            'Price__c'
            };
    }

    /*
    * <Name>Icon</Name>
    * <Summary>To return a default set of strings</Summary>
    */
    @TestVisible
    private static Set<String> selectCarPage() {
        return new Set<String>{
            'metadataCar__r.Id',
            'metadataCar__r.DeveloperName',
            'metadataCar__r.MasterLabel',
            'metadataCar__r.QualifiedApiName'
            };
    }

}