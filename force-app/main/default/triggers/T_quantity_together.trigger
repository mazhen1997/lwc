trigger T_quantity_together on T_Shipment__c (before insert,before update) {
    List<T_Shipment_Detail__c> sdLst= new list<T_Shipment_Detail__c>();
     String ShipmentId = Trigger.new.get(0).Id;
    
    sdLst = [select Id,N_Qty__c from T_Shipment_Detail__c where T_Shipment__c= :ShipmentId];
    
    Double Quantity = 0;
    
   for(T_Shipment_Detail__c sd : sdLst ){
        Quantity = Quantity + sd.N_Qty__c;
   }
   Trigger.new.get(0).N_TotalQty__c = Quantity;    
}