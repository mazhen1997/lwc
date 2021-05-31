({
	close : function(component, event, helper) {
		component.set("v.open",false);
        var onEvent = component.getEvent("onclose");
		onEvent.fire();
	}
})