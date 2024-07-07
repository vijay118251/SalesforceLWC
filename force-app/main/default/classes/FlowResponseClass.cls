public with sharing class FlowResponseClass {
    
    public FlowResponseClass() {
        //constructor
    }
    
    public class flowInputs {
        @InvocableVariable
        public string name;
        @InvocableVariable
        public string cpuModel;
        @InvocableVariable
        public string hardDisk;
        @InvocableVariable
        public Integer year;
        @InvocableVariable
        public Integer price;
        
    }
    
    @InvocableMethod(label='Pass Flow Response')
    public static List<flowOutputs> getFlowVariables(List<flowInputs> inputs) {
        system.debug('flow inputs-->'+inputs);
        //Get Ouput values
        List<flowOutputs> returnVarList = new List<flowOutputs>();
        flowOutputs returnVar = new flowOutputs();
        returnVar.strResponse = JSON.serialize(inputs);
        returnVarList.add(returnVar);
        system.debug('flow outputs-->'+returnVarList);
        return returnVarList;
    }
    
    public class flowOutputs {
        @InvocableVariable
        public string strResponse;
    }

}