public class AsynchronousApexPractice {
	public void invokeFuture()
    {
        FutureMethod1();
        FutureMethod2();
        NormalMethod1();
        NormalMethod2();
    }
    
    @future
    public static void FutureMethod1(){
        System.debug('Inside future1');
    }
    
    @future
    public static void FutureMethod2(){
        System.debug('Inside future2');
    }
    
    public void NormalMethod1(){
        System.debug('Inside NormalMethod1');
    }
    
    public void NormalMethod2(){
        System.debug('Inside NormalMethod2');
    }
}