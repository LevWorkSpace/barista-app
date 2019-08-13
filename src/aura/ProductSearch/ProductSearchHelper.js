({
    getProducts: function(component) {
        let action = component.get("c.getActiveProductsWithSections");
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                let result = response.getReturnValue();
                component.set('v.sectionToProducts', result.sectionToProducts);
                component.set('v.sectionNames', result.sectionNames);
                let firstSelected = result.sectionNames[0] ? result.sectionNames[0] : '';
                component.set('v.selectedSection', firstSelected);
                component.set('v.selectedSectionProducts', result.sectionToProducts[firstSelected] ? result.sectionToProducts[firstSelected] : []);
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