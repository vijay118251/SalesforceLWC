public class MetadataIconSelector {
    
    /*Enforce Security*/
    @TestVisible
    private Boolean enforceSecurity = false;
    /*Order By*/
    private String orderBy = null;
    /*Field Set*/
    private Final List<FieldGroup> fieldSet = new List<FieldGroup>();
    /*Enum Field Group*/
    public enum FieldGroup { ICON,ICONTRAY }
    
    /*
* <Name>Constructor</Name>
* <Summary>Uses the default values for the fields to return</Summary>
*/
    public MetadataIconSelector() {
        this.fieldSet.add(FieldGroup.ICON);
        this.fieldSet.add(FieldGroup.ICONTRAY);
    }
    
    /*
* <Name>Constructor</Name>
* <Summary>allows the configuration</Summary>
* <Parameters>Boolean enforce,Boolean strip,String order</Parameters>
*/
    public MetadataIconSelector(Boolean enforce, String order) {
        this.enforceSecurity = enforce;
        this.orderBy = order;
    }
    
    /*  allows the enforceSecurity constructed*/
    public MetadataIconSelector setEnforceSecurity(Boolean enforce) {
        this.enforceSecurity = enforce;
        return this;
    }
    
     /*
    * <Name>generateQueryString</Name>
    * <Summary>Generate a SOQL query in a database query</Summary>
    * <Parameter>fields, Where, Order and enforceSecurity</Parameter>
    */
    private String generateQueryString(List<String> fields, String wher) {
        system.debug('fields-->'+fields);
        system.debug('join fields-->'+String.join(fields,', '));
        final String genQuery = 'SELECT ' + String.join(fields,', ')
            +' FROM MetadataIcon__mdt'
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
    public List<MetadataIcon__mdt> selectIconByPage(String pageName) {
        final String wher = 'DeveloperName =: pageName';
        final String execQuery = generateQueryString(fieldList(), wher);
        system.debug('execQuery--->'+execQuery);
        final List<MetadataIcon__mdt> iconGroups = Database.query(execQuery);
        system.debug('iconGroups--->'+iconGroups);
        return iconGroups;
    }
    
    /*
    * <Name>fieldList</Name>
    * <Summary>To return a list of strings</Summary>
    */
    private List<String> fieldList() {
        final List<String> returnList = new List<String>();
        /*ICON*/
        if(this.fieldSet.contains(FieldGroup.ICON)) {
            returnList.addAll(selectIcon());
        }
        return returnList;
    }
    
    /*
* <Name>Icon</Name>
* <Summary>To return a default set of strings</Summary>
*/
    @TestVisible
    private static Set<String> selectIcon() {
        return new Set<String>{
            'Id',
            'DeveloperName',
            'MasterLabel',
            'Label',
            'QualifiedApiName',
            'title__c',
            'subtitle__c',
            'icon__c',
            'color__c',
            'componentName__c',
            'colorType__c',
            'dispatcher__c',
            'titleType__c',
            'subtitleType__c',
            'iconType__c',
            'notifyCircleColor__c',
            'notifyCirclePosition__c',
            'enableIconType__c',
            'notifyCircleColorType__c',
            'notifyCirclePositionType__c',
            'propertyType__c',
            'property__c',
            'method__c',
            'enableIcon__c',
            'componentNameType__c',
            'hoverText__c',
            'hoverTextType__c',
            'notifyCircleTopLeftColorType__c',
            'notifyCircleTopLeftColor__c',
            'notifyCircleTopLeftValue__c',
            'notifyCircleTopLeftValueType__c',
            'notifyCircleTopRightColor__c',
            'notifyCircleTopRightColorType__c',
            'notifyCircleTopRightValue__c',
            'notifyCircleTopRightValueType__c'
            };
    }
    
}