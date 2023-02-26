global class BlogDataSourceConnection extends DataSource.Connection {
    private static string Base_url= 'https://sfdcstop.herokuapp.com';
    private static string blog_endpoint = '/blogs';

    global BlogDataSourceConnection(DataSource.ConnectionParams connectionInfo) {}

    override global List<DataSource.Table> sync() {
        List<DataSource.Table> tables =new List<DataSource.Table>();
        List<DataSource.Column> blogColumns = new List<DataSource.Column>();
        blogColumns.add(DataSource.Column.text('Author',255));
        blogColumns.add(DataSource.Column.text('id',255));
        blogColumns.add(DataSource.Column.text('title',255));
        blogColumns.add(DataSource.Column.url('url',255));
        blogColumns.add(DataSource.Column.text('ExternalId',255));
        blogColumns.add(DataSource.Column.url('DisplayUrl'));
        tables.add(DataSource.Table.get('Blogs','Blogs',blogColumns));
        return tables;
    }

    override global DataSource.TableResult query(DataSource.QueryContext context) {
        String table = context.tableSelection.tableSelected;
        system.debug('table-->'+ table);
        return DataSource.TableResult.get(context, DataSource.QueryUtils.process(context, getRows(table)));
    }
    
    // Helper method to get record values from the external system for the Sample table.
    private List<Map<String, Object>> getRows (String table) {
        String url = Base_url;
        if(table.equals('Blogs')) {
            url += blog_endpoint;
            system.debug('url-->'+ url);
        }
        HttpResponse response = makeGetCallout(url);
        String ResponseText = response.getBody();
        system.debug('response-->'+ ResponseText);
        // Parse the JSON response and populate the rows.
        final BlogClass blogDetails = BlogClass.parse(ResponseText);
        system.debug('blogDetails-->'+ blogDetails);
        return populateBlogRow(blogDetails);
    }
    private static HttpResponse makeGetCallout(String url) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        return http.send(req);
    }
    
    private List<Map<String, Object>> populateBlogRow(BlogClass newRow) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        integer inc = 0;
        system.debug('newRow-->'+ newRow);
        for(BlogClass.Blogs blog: newRow.blogs) {
         Map<String, Object> row = new Map<String, Object>();
        inc++;
            row.put('ExternalId',blog.id);
            row.put('DisplayUrl', Base_url + blog_endpoint);
            row.put('Author', newRow.author);
            row.put('title', blog.title);
        	row.put('url', blog.url);
            rows.add(row);
    	} 
        return rows;
    }
}