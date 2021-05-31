trigger returnproduct on productReturn__c (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            List<productReturn__c> newlist =Trigger.new;
            if(newlist.size()>0){
                System.debug('newlist------>'+newlist);
                String rname=newlist.get(0).name;
                if(rname == 'iphonexs'){
                    newlist.get(0).rpeoductcode__c ='RHI01029XS';
                    
                }
            }
            
        }
    }

}