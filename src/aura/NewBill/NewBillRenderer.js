({
	afterRender : function(component, helper) {
        this.superAfterRender();
        /*let table = component.find('card').getElement();
        table.addEventListener("touchmove", function(e) {
            e.stopPropagation();
        }, false);
        let search = component.find('productSearch').getElement();
        search.addEventListener("touchmove", function(e) {
            e.stopPropagation();
        }, false);*/
    }
})