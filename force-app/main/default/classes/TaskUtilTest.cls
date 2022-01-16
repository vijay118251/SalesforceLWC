@isTest
private class TaskUtilTest {
    @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
    @isTest static void testTaskPriority1() {
        String pri = TaskUtil.getTaskPriority('CA');
        System.assertEquals('High', pri);
    }
    @isTest static void testTaskPriority2() {
        String pri = TaskUtil.getTaskPriority('montana');
        System.assertEquals('null', pri);
    }
}