/*
 * <Author>TCS <Author>
 * <History> HLXR-337 </History>
 */

public with sharing class APIErrorHandler{


    /* error code 404 */
    final static String CODE = '404';
    /*
     * <Name>getErrorRow</Name>
     * <Summary>Public interface to retrieve error
     * description based on the error code</Summary>
     */ 
    public static List<Map<String,Object>> getErrorRows(ErrorDetail error) {
        final List<Map<String,Object>> errorRow = new List<Map<String,Object>>();
        if(error.errorCode != CODE){
            final apiError__mdt metadataErrorDetails = apiError__mdt.getInstance('error'+error.errorCode);
            final String errorDesc = metadataErrorDetails != null ? metadataErrorDetails.errorDescription__c: error.errorMessage;
            errorRow.add(new Map<String, Object>{ 'error' => errorDesc });
        }
        return errorRow;
    }

    /*
     * <Name>checkError</Name>
     * <Summary>Public interface to retrieve error 
     * description based on the error code</Summary>
     */   
    public static Boolean errorCheck(List<Map<String,Object>> returnRows) {
        if(returnRows!=null && returnRows.size()>0 && returnRows[0].get('error') != null) {
            throw new customAPIException(returnRows[0].get('error').toString());
        }
        return false;
    }

    /* customAPIException */
    public class customAPIException extends Exception {}
}