public class MyApexClass {
    public static void doubler(Double input) {
        Invocable.Action action = Invocable.Action.createCustomAction('apex', 'Doubler');
        action.setInvocationParameter('input', 1);
        List<Invocable.Action.Result> results = action.invoke();                                          
        if (results.size() > 0 && results[0].isSuccess()) {
            System.debug('Result is: ' + results[0].getOutputParameters().get('output'));
        }
    }
}