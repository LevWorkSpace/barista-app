({
    afterRender: function (component, helper) {
        this.superAfterRender();
        component.addEventHandler("touchmove", function(e) {e.stopPropagation();});
    }
})