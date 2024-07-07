public class WrapperPractice {
    
    public String Idd;
    
    public Employee employee;
    
    public class Employee{
        public String name;
        public Role role;
    }
    public static void method(){
        Employee empWrap = new Employee();
        Role r = new Role();
        r.design='rtyu';
        empWrap.role=r;
        System.debug('empWrap-->'+empWrap);
    }
    
}