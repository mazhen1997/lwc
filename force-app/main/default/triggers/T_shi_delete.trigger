trigger T_shi_delete on T_Shipment__c (before delete) {
    List<T_Shipment_Detail__c> sdLst = new List<T_Shipment_Detail__c>();
    String ShipmentId = Trigger.old.get(0).Id;
    sdLst = [select Id,N_Qty__c from T_Shipment_Detail__c where T_Shipment__c = :ShipmentId];
    delete sdLst;

}