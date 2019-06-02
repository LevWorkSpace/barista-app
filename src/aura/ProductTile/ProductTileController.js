({
    onProductClick : function(component, event, helper) {
        let product = component.get("v.product");
        var selected = component.getEvent("productSelected");
        selected.setParam("product", Object.assign({}, product));
        selected.fire();
    }
})