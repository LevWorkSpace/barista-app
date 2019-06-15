({
    getProducts: function(component) {
        let action = component.get("c.getActiveProducts");
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                let sections = response.getReturnValue();
                component.set('v.selectedSection', sections[0] ? sections[0].name : '');
                component.set('v.sections', sections);
            } else {
                this.handleErrors(response.getError());
            }
        });
        $A.enqueueAction(action);
    },

    handleErrors: function(errors) {
        if (errors && errors[0] && errors[0].message) {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error!",
                "type" : "error",
                "message": errors[0].message
            });
            toastEvent.fire();
        } else {
            console.log("Unknown error");
        }
    },

    closePopup: function(component) {
        component.set('v.open', false);
    }
})