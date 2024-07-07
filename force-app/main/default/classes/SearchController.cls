public with sharing class SearchController {
    public SearchController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> searchMethod(String ObjectApiName,List<String> fields, String searchName) {
        try {
            if (String.isNotBlank(ObjectApiName)&& !fields.isEmpty() && String.isNotBlank(searchName)) {
                // Dynamically build and execute SOQL query based on parameters
                String fieldString = String.join(fields,',');
                String Query = 'SELECT ' +fieldString+ ' FROM ' +ObjectApiName+ ' WHERE Name LIKE \''+String.escapeSingleQuotes(searchName)+'%\'';
                System.debug('Query-->'+Query);
                // Execute the query and process results
                List<SObject> records = Database.query(query);
                System.debug('accList-->'+records);
                return records;
            }
            else {
                return new List<SObject>();
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}