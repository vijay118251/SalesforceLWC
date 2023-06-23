/**
 * @Date     :    08-Mar-2022
 * @Author   :    Vijay 
 * @Desc     :     DataSource.Provider class informs Salesforce of the functional and 
 * authentication capabilities that are supported by or required to connect to the external system
 * */
global class MSAExternalDataSourceProvider extends DataSource.Provider {
     
    /**
     * Define list of Supported Authentication capability for the external object 
     **/
    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        List<DataSource.AuthenticationCapability> capabilities =  new List<DataSource.AuthenticationCapability>();
        capabilities.add(DataSource.AuthenticationCapability.ANONYMOUS);
         return capabilities;
     }
    
    /**
     * This method provides us with the list of capabilities supported by Custom Adapters 
     **/
    override global List<DataSource.Capability> getCapabilities()
    {
        List<DataSource.Capability> capabilities = new
            List<DataSource.Capability>();
        capabilities.add(DataSource.Capability.ROW_QUERY);
        capabilities.add(DataSource.Capability.SEARCH); 
        return capabilities;
    }
    
    /**
     *  obtain the external system’s schema and handle 
     *  the queries and searches of the external data
     **/
    override global DataSource.Connection getConnection(DataSource.ConnectionParams connectionParams) {   
        return new MSAExternalDataSourceConnection(connectionParams);
    } 
}