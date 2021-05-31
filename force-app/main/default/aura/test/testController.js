({
    doInit : function(component, event, helper) {
        var staticLabel = $A.get("$Label.c.button_name");
        
        component.set("v.btn", staticLabel);

	       var totalCnt = component.get("c.getTotalCount");
        totalCnt.setCallback(this, function(a) {
            console.log(a.getReturnValue());
            component.set("v.totalNumberOfRows", a.getReturnValue());
        });
        $A.enqueueAction(totalCnt);
        
   
        
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Id', type: 'text',sortable:true },
            {label: 'URL', fieldName: 'Name', type: 'text',sortable:true},
            {label: 'Author Name', fieldName: 'Id', type: 'text',sortable:true},
            {label: 'publish status', fieldName: 'Name', type: 'text',sortable:true},
            {label: 'Publisher Id', fieldName: 'Name', type: 'text',sortable:true},
  
        ]);
        helper.getData(component);
    },

    loadMoreData: function (component, event, helper) {
        //Display a spinner to signal that data is being loaded
        event.getSource().set("v.isLoading", true);
        //Display "Loading" when more data is being loaded
        component.set('v.loadMoreStatus', 'Loading');
        helper.fetchData(component, component.get('v.rowsToLoad')).then($A.getCallback(function (data) {
           
            if (component.get('v.data').length >= component.get('v.totalNumberOfRows')) {
                               component.set('v.enableInfiniteLoading', false);
                component.set('v.loadMoreStatus', 'No more data to load');
            } else {
               
                var currentData = component.get('v.data');
                //Appends new data to the end of the table
                var newData = currentData.concat(data);
                component.set('v.data', newData);
                component.set('v.loadMoreStatus', 'Please wait ');
    
            }
            event.getSource().set("v.isLoading", false);
        }));
    },
    

    
})