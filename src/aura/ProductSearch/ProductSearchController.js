({
    init: function(component, event, helper) {
        helper.getProducts(component);
    },

    closePopup: function(component, event, helper) {
        helper.closePopup(component);
    },

    handleProductSelected: function(component, event, helper) {
        component.find("customToast").showMessage("success", event.getParam('product').name + " was added to the Bill.", 2000);
    },

    selectSection: function(component, event, helper) {
        let selectedSection = event.getSource().get("v.labelWhenOn");
        component.set('v.selectedSection', selectedSection);
    }
})