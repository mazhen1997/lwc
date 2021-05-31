({
    getData : function(component) {
        
        var action = component.get("c.getBooks");
        action.setParams({
            "limits": component.get("v.initialRows"),
            "offsets": component.get("v.rowNumberOffset")
        });
        action.setCallback(this, function(a) {
            component.set("v.data", a.getReturnValue());
            component.set("v.currentCount", component.get("v.initialRows"));
            
        });
        $A.enqueueAction(action);
    },
    fetchData: function(component , rows){
        return new Promise($A.getCallback(function(resolve, reject) {
            var currentDatatemp = component.get('c.getBooks');
            var counts = component.get("v.currentCount");
            currentDatatemp.setParams({
                "limits": component.get("v.initialRows"),
                "offsets": counts 
            });
            console.log('new function ');
            currentDatatemp.setCallback(this, function(a) {
                resolve(a.getReturnValue());
                var countstemps = component.get("v.currentCount");
                countstemps = countstemps+component.get("v.initialRows");
                component.set("v.currentCount",countstemps);
                
            });
              console.log('temp function ');
            $A.enqueueAction(currentDatatemp);
            
            
        }));
        
    } 
})