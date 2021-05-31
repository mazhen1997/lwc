({
    onfocus : function(component,event,helper){
        $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
        console.log("switch-->"+component.get("v.switchOncePublic"));
        
        if(component.get("v.switchOncePublic") == false){
            component.set("v.switchOncePublic",true)
            for(var i = 0; i < 99999 ; i++) {
                (function(i) {
                    setTimeout(function() {
                        if(component.get("v.deleteSwitch") == false){
                            var pillTarget = component.find("lookup-pill");
                            var lookUpTarget = component.find("lookupField"); 
                            
                            $A.util.addClass(pillTarget, 'slds-hide');
                            $A.util.removeClass(pillTarget, 'slds-show');
                            
                            $A.util.addClass(lookUpTarget, 'slds-show');
                            $A.util.removeClass(lookUpTarget, 'slds-hide');
                            
                            component.set("v.SearchKeyWord",null);
                            component.set("v.listOfSearchRecords", null );
                            component.set("v.selectedRecord", {} );   
                        }
                    }, (i + 1) * 1000);
                })(i)
            }
        }
        
        
    },
    onblur : function(component,event,helper){       
        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    keyPressController : function(component, event, helper) {
        var getInputkeyWord = component.get("v.SearchKeyWord");
        console.log("getInputkeyWord-->"+getInputkeyWord);
        if( getInputkeyWord.length > 0 ){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{  
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    clear :function(component,event,heplper){
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField"); 
        
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );   
    },
    handleComponentEvent : function(component, event, helper) {
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        console.log("event-->"+selectedAccountGetFromEvent)
        component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');  
        
    },
    uploadInit : function(component, event, helper) {
        var downloadIframe = component.find("uploadIframe").getElement();
        component.set("v.uploadDialogOpen",true);
    },
    initHandleComponentEvent : function(component, event, helper) {
        for(var i = 0; i < 999 ; i++) {
            (function(i) {
                setTimeout(function() {
                    if(component.get("v.initialQuery") != undefined && component.get("v.initialQuery") != ''){
                        if(component.get("v.initialSwitch") == true){
                            helper.InitialQuery(component,event,helper).then(function(initSelectedAccountGetFromEvent){ 
                                component.set('v.additionalWhere','');
                                //console.log(initSelectedAccountGetFromEvent)
                                var selectedAccountGetFromEvent = initSelectedAccountGetFromEvent;
                                console.log(selectedAccountGetFromEvent);
                                if(selectedAccountGetFromEvent != undefined){
                                    component.set("v.initialSwitch",false)
                                }
                                component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
                                var forclose = component.find("lookup-pill");
                                $A.util.addClass(forclose, 'slds-show');
                                $A.util.removeClass(forclose, 'slds-hide');
                                
                                var forclose = component.find("searchRes");
                                $A.util.addClass(forclose, 'slds-is-close');
                                $A.util.removeClass(forclose, 'slds-is-open');
                                
                                var lookUpTarget = component.find("lookupField");
                                $A.util.addClass(lookUpTarget, 'slds-hide');
                                $A.util.removeClass(lookUpTarget, 'slds-show'); 
                                
                            });  
                        }
                    }
                }, (i + 1) * 500);
            })(i)
        }        
    },
})