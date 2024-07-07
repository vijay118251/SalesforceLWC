public class TestApexClass {
    public static void sampleMethod(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('A','United States'));
        options.add(new SelectOption('C','Canada'));
        options.add(new SelectOption('A','Mexico'));
        options.sort();
        System.debug(options);
}
}