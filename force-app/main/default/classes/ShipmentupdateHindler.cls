public class ShipmentupdateHindler {
    private static List<String> trueFlagIdList = new List<String>();
     public void execute() {
     
      //zhen.a.ma add start 2021/01/29
      if(Trigger.isUpdate && Trigger.isBefore){
        this.onBeforeUpdate((Map<Id,T_Shipment__c>)Trigger.newMap);
      }
      //zhen.a.ma add end 2021/01/29
      if(Trigger.isUpdate && Trigger.isAfter){
        this.onAfterUpdate((Map<Id,T_Shipment__c>)Trigger.newMap);
      }
    
    

     }

          public void onBeforeUpdate(Map<Id,T_Shipment__c> newList){
              for(T_Shipment__c t:newList.values()){
                  trueFlagIdList.add(t.id);
                  trueFlagIdList.add(t.id);
              }
              System.debug('trueFlagIdList-before--->'+trueFlagIdList);
              
              
              
          }
          public void onAfterUpdate(Map<Id,T_Shipment__c> newList){
             String aa;
              trueFlagIdList.add('cccc');
              System.debug('trueFlagIdList--after-->'+trueFlagIdList);
              for(T_Shipment__c t:newList.values()){
                  if(trueFlagIdList.contains(t.Id)){
                      aa=t.Id;
                      trueFlagIdList.remove(trueFlagIdList.indexOf(t.Id));
                  }
                  
              }
              System.debug(trueFlagIdList);
               System.debug(aa);
              
          }

}