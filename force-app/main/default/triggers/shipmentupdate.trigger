trigger shipmentupdate on T_Shipment__c (before update,after update) {
    ShipmentupdateHindler si = new ShipmentupdateHindler();
    si.execute();
    

}