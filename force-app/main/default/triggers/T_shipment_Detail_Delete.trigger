trigger T_shipment_Detail_Delete on T_Shipment_Detail__c (after delete) {
    String ShipmentId = Trigger.old.get(0).T_Shipment__c;
    
    List<T_Shipment__c> sLst = new List<T_Shipment__c>();
    sLst = [select Id,N_TotalQty__c from T_Shipment__c where id = :ShipmentId];
    
    List<T_Shipment_Detail__c> sdLst= new list<T_Shipment_Detail__c>();
    sdLst = [select Id,N_Qty__c from T_Shipment_Detail__c where T_Shipment__c= :ShipmentId];
    
    Double Quantity = 0;
    
    for(T_Shipment_Detail__c sd:sdLst ){
        Quantity=Quantity+sd.N_Qty__c;
    }
    
    sLst.get(0).N_TotalQty__c= Quantity;
    update sLst;
}