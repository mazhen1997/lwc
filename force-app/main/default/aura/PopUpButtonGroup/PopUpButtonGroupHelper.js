({
	helperMethod : function(cmp,event) {
		var action = cmp.get("c.getParams");
        action.setParams({
            'name':cmp.get("v.entity")
        });
        action.setCallback(this,$A.getCallback(function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var returnValue = response.getReturnValue();
                console.log(returnValue);
            }else if (state === "ERROR"){
                var errors = response.getError();
                console.log(errors);
            }
        }));
        $A.enqueueAction(action);
	}
})