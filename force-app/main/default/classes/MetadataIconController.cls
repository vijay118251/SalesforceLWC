public class MetadataIconController {
    
    /* Default constructor */
    public MetadataIconController() {
        system.debug('Calling MetadataIconController');
    }
    
    /*PlanType*/
    
    public PlanType planType;
    /*enum plan type*/
    public enum PlanType {DRIVE,WELLNESS}
    /*setPlanType*/
    public MetadataIconController setPlanType(planType type) {
        this.planType = type;
        return this;
    }
    
    /*Wrapper*/
    @TestVisible
    public class MetadataWrapper {
        /*CaffeNero history*/
        @AuraEnabled
        public MetadataWrapperDetails details { get; set; }
        /* constructor */
        @TestVisible
        private MetadataWrapper() {
        }
    }
    
    /* details wrapper used inside main wrapper*/
    @TestVisible
    public class MetadataWrapperDetails {
        /* method name*/
        @AuraEnabled
        public String status { get; set; }
    }
    
    @AuraEnabled
    public static MetadataWrapperDetails methodName(String planType) {
        MetadataWrapperDetails detailsWrap = new MetadataWrapperDetails();
        try {
            final MetadataIconController.PlanType plType = planType == 'Drive'
                ? MetadataIconController.PlanType.DRIVE
                : MetadataIconController.PlanType.WELLNESS;
            final String planStatus = planType;
            detailsWrap.status = planStatus;
        }
        catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        system.debug('detailsWrap'+detailsWrap);
        return detailsWrap;
    }
}