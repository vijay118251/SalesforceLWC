/*
 * <Author> Surya G, TCS</Author>
 * <Purpose>Query Static resource to get JSON file</Purpose>
 * <History>HLX-3832</History>
 */
public inherited sharing class StaticResourceSelector {
    /*Field Set*/
    private final List<FieldGroup> fieldSet = new List<FieldGroup>();
    /*Enum Field Group*/
    public enum FieldGroup {
        RESOURCE
    }

    /*
     * <Name>Constructor</Name>
     * <Summary>Uses the default values for the fields to return</Summary>
     */
    public StaticResourceSelector() {
        this.fieldSet.add(FieldGroup.RESOURCE);
    }

    /*
     * <Name>Constructor</Name>
     * <Summary>allows the client to define the set of fields to
     *          be returned in queries</Summary>
     * <Parameter>Set<FieldGroup> fields</Parameter>
     */
    public StaticResourceSelector(Set<FieldGroup> fields) {
        this.fieldSet.addAll(new List<FieldGroup>(fields));
    }

    /*add Field Set*/
    public StaticResourceSelector addFieldSet(FieldGroup groupType) {
        this.fieldSet.add(groupType);
        return this;
    }

    /*Remove Field Set*/
    public StaticResourceSelector removeFieldSet(FieldGroup groupType) {
        for (Integer i = 0; i < this.fieldSet.size(); i++) {
            if (this.fieldSet[i] == groupType) {
                this.fieldSet.remove(i);
            }
        }
        return this;
    }

    /*
     * <Name>getSelectFields</Name>
     * <Summary>To return a default set of strings</Summary>
     */
    @TestVisible
    private static Set<String> getSelectFields() {
        return new Set<String>{
            'Id',
            'NamespacePrefix',
            'Name',
            'ContentType',
            'BodyLength',
            'Body',
            'Description',
            'CreatedDate',
            'CreatedById',
            'LastModifiedDate',
            'LastModifiedById',
            'SystemModstamp',
            'CacheControl'
        };
    }

    /*
     * <Name>getFieldList</Name>
     * <Summary>To return a list of strings</Summary>
     */
    private List<String> getFieldList() {
        final List<String> returnList = new List<String>();
        /*RESOURCE*/
        if (fieldSet.contains(FieldGroup.RESOURCE)) {
            returnList.addAll(getSelectFields());
        }
        return returnList;
    }

    /*
     * <Name>generateQueryString</Name>
     * <Summary>Generate a SOQL query in a database query</Summary>
     * <Parameter>fields, static resource name</Parameter>
     */
    private static String generateQueryString(List<String> fields, String name) {
        return 'SELECT ' +
            String.join(fields, ', ') +
            ' FROM StaticResource' +
            ' WHERE Name=' +
            '\'' +
            String.escapeSingleQuotes(name) +
            '\'';
    }

    /*
     * <Name>selectByName</Name>
     * <Summary>Pass static resource name to get mock JSON response</Summary>
     * <Parameter>Static resource name</Parameter>
     */
    public StaticResource selectByName(String name) {
        List<StaticResource> statResource = new List<StaticResource>();
        /* generate query */
        final String execQuery = generateQueryString(getFieldList(), name);
        statResource = Database.query(execQuery);
        return statResource.isEmpty() ? new StaticResource() : statResource[0];
    }
}