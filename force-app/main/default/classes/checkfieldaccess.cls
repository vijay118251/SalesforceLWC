public class checkfieldaccess {
    @InvocableMethod(label='Check Field Permission')
    public static List<Boolean> isRead(List<String> objectField) {
        return new List<Boolean> {Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().get('Birthdate').getDescribe().isAccessible()};
    }

}