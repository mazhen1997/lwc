({
    searchHelper : function(component,event,getInputkeyWord) {
        console.log('11111');
        var action = component.get("c.fetchLookUpValues");
        var groupSelect = component.get("v.groupSelect");
        console.log("groupSelect-->"+groupSelect);
        var groupId = groupSelect.Id;
        var groupName = groupSelect.Name;
        console.log("objectAPIName-->"+component.get("v.objectAPIName"));
        console.log("additionalWhere-->"+component.get('v.additionalWhere'));        
        
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'objectName' : component.get("v.objectAPIName"),
            'groupSelect' : groupSelect,
            'additionalWhere' : component.get('v.additionalWhere')
        });
        action.setCallback(this, function(response) {
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log("storeResponse.length-->"+storeResponse.length);
                console.log("storeResponse-->"+storeResponse);
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                }else {
                    component.set("v.Message", '');
                }
                if(groupId == undefined && groupName == undefined){
                     console.log("if");
                    component.set("v.listOfSearchRecords", storeResponse);
                }else{
                     console.log("else");
                    var storeResponseGroups = [];
                    console.log("else");
                    for(var i = 0 ; i < storeResponse.length ; i++){
                        var storeResponseGroup = {};
                        storeResponseGroup.Id = storeResponse[i][groupId];
                        console.log("ID-->"+storeResponseGroup.Id);
                        storeResponseGroup.Name = storeResponse[i][groupName];
                         console.log("Name-->"+storeResponseGroup.Name);
                        storeResponseGroups[i] = storeResponseGroup;
                    }
                    console.log("storeResponseGroups-->"+storeResponseGroups);
                    component.set("v.listOfSearchRecords", storeResponseGroups);
                }
            }
        });
        $A.enqueueAction(action);
        
    },
    InitialQuery : function(component,event,helper) {
        return new Promise($A.getCallback(function(resolve){
            var action = component.get("c.initialFetchLookUpValues");
            console.log("initialQueryId-->"+component.get("v.initialQuery"));
            console.log("objectName-->"+component.get("v.objectAPIName"));
            action.setParams({
                'initialQueryId': component.get("v.initialQuery"),
                'objectName' : component.get("v.objectAPIName")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var storeResponse = response.getReturnValue();
                    console.log("storeResponse-->"+storeResponse);
                    resolve(storeResponse[0]);
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    console.error(errors);
                }
            });
            $A.enqueueAction(action);
        }));
    },
})