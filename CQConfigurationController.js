({
    init : function(component, event, helper) {
        var action = component.get("c.getPartRecFromCQ");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Part records synced successfully!");
            }
        });
        $A.enqueueAction(action);
    },
    handleSyncClick : function(component, event, helper) {
        var action = component.get("c.getPartRecFromCQ");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Part records synced successfully!");
            }
        });
        $A.enqueueAction(action);
    }
})