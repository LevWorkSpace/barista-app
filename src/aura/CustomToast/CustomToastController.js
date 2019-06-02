({
    showMessage: function(component, event, helper) {
        var params = event.getParam('arguments');
        helper.showMessage(params.message, params.type, params.timeout, component);
    }
})