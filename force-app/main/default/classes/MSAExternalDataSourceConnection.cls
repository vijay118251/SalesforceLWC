/**
 * @Date     :    08-Mar-2022
 * @Author   :    YCS
 * @Desc     :     MSAExternalDataSourceConnection class helps to get call
 * the MSAExternalSelector class and hansdle errors
 * */
global class MSAExternalDataSourceConnection extends DataSource.Connection {

    /* DataSource.Connection */
    private final DataSource.ConnectionParams connectionInfo;

    /*Constructor*/
    global MSAExternalDataSourceConnection(
        DataSource.ConnectionParams connectionInfo) {
            this.connectionInfo = connectionInfo;
        }

    /* The sync method helps the external data source to
     sync up with the external objects */
    override global List<DataSource.Table> sync() {
        return null;
    }

    /* The query method takes in context variable which will help
     to generate query using other methods available */
    override global DataSource.TableResult query(DataSource.QueryContext context) {
        final List<Map<String,Object>> returnRows = MSAExternalSelector.getData(context);
        APIErrorHandler.errorCheck(returnRows);
        return DataSource.TableResult.get(context,  DataSource.QueryUtils.process(context, returnRows));

    }

    /* The query method takes in context variable which will help
     to generate query using other methods available 
    override global List<DataSource.TableResult> search( DataSource.SearchContext context)
    {
         final List<Map<String,Object>> returnRows = MSAExternalSearch.getData(context);
         APIErrorHandler.errorCheck(returnRows);
         final List<DataSource.TableResult> results = new List<DataSource.TableResult>();
        for (DataSource.TableSelection tableSelection : context.tableSelections) {
            results.add(DataSource.TableResult.get(tableSelection, returnRows));
        }
       return results;
     }*/
}