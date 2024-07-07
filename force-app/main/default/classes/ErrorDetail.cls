/*
 * @author Jaroslav Nemec, Bluewolf
 * @date 06/03/2019
 * @group Vitality
 * @description Error Details for response
 */
public class ErrorDetail {
    /*errorCode*/
    @AuraEnabled
    public String errorCode { get; set; }
    /*errorDateTime*/
    @AuraEnabled
    public String errorDateTime { get; set; }
    /*errorMessage*/
    @AuraEnabled
    public String errorMessage { get; set; }
    /*errorDescription*/
    @AuraEnabled
    public String errorDescription { get; set; }
    
    /* ERR_CODE */
    private static final String ERROR_CODE = 'errorCode';
    /* ERR_DATE_TIME */
    private static final String ERR_DATE_TIME = 'errorDateTime';
    /* ERR_MSG */
    private static final String ERR_MSG = 'errorMessage';
    /* ERR_DESCRPTION */
    private static final String ERR_DESCRPTION = 'errorDescription';
    /* ERR_DESCRPTION */
    private static final String NEW_ERR_MSG = 'error';

    /*ErrorDetails*/
    public ErrorDetail(JSONParser parser) {
        /*check nextToken*/
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            /*check CurrentToken*/
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                /*text*/
                final String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == ERROR_CODE) {
                        errorCode = parser.getText();
                    } else if (text == ERR_DATE_TIME) {
                        errorDateTime = parser.getText();
                    } else if (text == ERR_MSG) {
                        errorMessage = parser.getText();
                    } else if (text == ERR_DESCRPTION) {
                        errorDescription = parser.getText();
                    } else {
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    /* ErrorDetails Parse method*/
    public static ErrorDetails parse(String json) {
        final System.JSONParser parser = System.JSON.createParser(json);
        return getErrors(parser);
    }
     
    /*error constructor*/
    public static ErrorDetails getErrors(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                final String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == NEW_ERR_MSG) {
                       // return new ErrorDetail(parser);
                    } else {
                        consumeObject(parser);
                    }
                }
            }
        }
        return null;
    }

    /*ErrorDetails*/
    public ErrorDetail(String errorCode, String errorMessage) {
        /*errorCode*/
        this.errorCode = errorCode;
        /*errorMessage*/
        this.errorMessage = errorMessage;
    }

    /*ErrorDetails*/
    public ErrorDetail(String errorCode, String errorMessage, String errorDesc) {
        /*errorCode*/
        this.errorCode = errorCode;
        /*errorMessage*/
        this.errorMessage = errorMessage;
        /*errorDescription*/
        this.errorDescription = errorDesc;
        /*errorDateTime*/
        this.errorDateTime = String.valueOf(System.now());
    }

    /*consumeObject*/
    private static void consumeObject(System.JSONParser parser) {
        /*depth*/
        Integer depth = 0;
        do {
            final System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT ||
                    curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                    curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        }
        while (depth > 0 && parser.nextToken() != null);
    }
}