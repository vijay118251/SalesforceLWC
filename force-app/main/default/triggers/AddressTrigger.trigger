trigger AddressTrigger on Account (before insert, after insert, before update) {
  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        Address.ShippingToBillingAddress(Trigger.new);
    }
        //Triggering HelloWorld
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        Address.HelloWorld(Trigger.new);
    }
 
}