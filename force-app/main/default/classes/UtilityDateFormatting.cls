public with sharing class UtilityDateFormatting {
    
      /*
* <Name>convertDate</Name>
* <Method>getDateString Conversion</Method>
*/
 public static String getDateString(String dte) {
    String dtstr;
    if(!String.IsBlank(dte)) {
        dtStr = dte.length()>11? dte.substringBefore('T'):dte;
        dtStr= String.valueOf((Date)JSON.deserialize('"' + dtStr + '"', Date.class));
        String[] dtStrs = dtstr.split('-');
        dtStr = dtStrs[2] + '/' + dtStrs[1] + '/' + dtStrs[0];
    }
    return dtStr;
    }
/*
* <Name>convertDateTime</Name>
* <Method>getDateAndTimeString</Method>~
*/
public static String getDateAndTimeString(String dte) {
    final String dteStr= String.isEmpty(dte) ? null : String.valueOf((DateTime)JSON.deserialize('"' + dte + '"', DateTime.class));
    return dteStr;
    }

}