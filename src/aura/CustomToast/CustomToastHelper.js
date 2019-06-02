({
    showMessage: function(message, type, userTimeout, component) {
        var messageContainer = component.find('message');

        component.set("v.type", type);
        component.set("v.message", message);

        component.set('v.isVisible', true);

        let timeout = component.get('v.timeout');
        if (type==='success')
            console.log(timeout);
        if (timeout !== null) {
            clearTimeout(timeout);
        }
        timeout = setTimeout($A.getCallback(function() {
            if (component.isValid()) {
                component.set('v.isVisible', false);
            }
        }), userTimeout || 7000);
        component.set('v.timeout', timeout);
    }
})