({
	helperMethod : function() {
		
	}
    /*
    
    ({
    searchpoduct_return_detailInfo : function(component){
        
        var action = component.get("c.getSearchResult");
        
        action.setCallback(this,function(response){
            
            var state = response.getState();
            if(state == 'SUCCESS'){
                var mixInfoList = response.getReturnValue();
                
                
                component.set("v.results",mixInfoList);
                // 実際取得済み件数
                component.set("v.count",mixInfoList.length);
                
            }
        });      
        
        // 队列处理
        $A.enqueueAction(action);
        
        
    },
    searchpoduct_return_detailHeaderInfo : function(component){
        var action = component.get("c.getHeaderInfo");
        
        action.setCallback(this,function(response){
            
            var state = response.getState();
            if(state == 'SUCCESS'){
                var mixInfoList = response.getReturnValue();
                
                   mixInfoList.forEach(function(record){
                       component.set("v.header01",record.TXT_return_number__c);
                       component.set("v.header02",record.TXT_reception_number__c);
                       component.set("v.header03",record.DAT_arrival_date__c);
                       component.set("v.header04",record.DAT_customer_buy_in_date__c);
                       component.set("v.header05",record.DAT_customer_move_in_date__c);
                       component.set("v.header06",record.TXT_title__c);
                       component.set("v.header07",record.TXT_hinban__c);
                       component.set("v.header08",record.N_quantity__c);
                       component.set("v.header09",record.PL_symptom__c);
                       component.set("v.header10",record.TXT_comment__c);
                   });
                
                
                
                
            }
        });      
        
        
        
        // 队列处理
        $A.enqueueAction(action);    
        
    } 
    
})
    
    
    
    
    
    
    ************************************************************************************************
    
    
    
    public with sharing  class G04_PoductReturnDetailSIE01 {
    @AuraEnabled
    public static List<T_poduct_return_detail_01__c> getSearchResult()
    {
        
        String soqlWhere = 'Where Id !=null limit 2 ';

        
        String colums ='Id' +
            ',Name' +
            ',TXT_return_number__c' +
            ',TXT_reception_number__c' +
            ',DAT_arrival_date__c' +
            ',DAT_customer_buy_in_date__c' +
            ',DAT_customer_move_in_date__c' +
            ',TXT_title__c' +
            ',PL_symptom__c' +
            ',TXT_comment__c' +
            ',TXT_hinban__c' +
            ',N_quantity__c' ;
        
        String soql = 'select ' + colums ;
        soql += ' From T_poduct_return_detail_01__c ';
        soql += soqlWhere;
        
        return (List<T_poduct_return_detail_01__c> )database.query(soql);
    }
    
    @AuraEnabled
    public static List<T_poduct_return_detail_01__c> getHeaderInfo()
    {
        
        String soqlWhere ='Where Id = ' + '\'a0cp0000002w7R9AAI\'' ;
        
        String colums ='Id' +
            ',Name' +
            ',TXT_return_number__c' +
            ',TXT_reception_number__c' +
            ',DAT_arrival_date__c' +
            ',DAT_customer_buy_in_date__c' +
            ',DAT_customer_move_in_date__c' +
            ',TXT_title__c' +
            ',PL_symptom__c' +
            ',TXT_comment__c' +
            ',TXT_hinban__c' +
            ',N_quantity__c' ;
        
        String soql = 'select ' + colums ;
        soql += ' From T_poduct_return_detail_01__c ';
        soql += soqlWhere;
        
        return (List<T_poduct_return_detail_01__c> )database.query(soql);
    }
}
    
    
    
    */
})