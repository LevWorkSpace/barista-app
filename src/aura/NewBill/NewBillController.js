({
    openProductSearch: function(component) {
        component.find('productSearch').set('v.open', true);
    },

    handleProductSelected: function(component, event, helper) {
        helper.addProduct(component, event.getParam('product'));
        helper.recalculateTotal(component, component.get('v.bill'), component.get('v.selectedProducts'));
    },

    recalculateTotal: function(component, event, helper) {
        helper.recalculateTotal(component, component.get('v.bill'), component.get('v.selectedProducts'));
    },

    saveBill: function(component, event, helper) {
        if (helper.validate(component)) {
            helper.saveBill(component, component.get('v.bill'), component.get('v.selectedProducts'));
        }
    },

    deleteFromBill: function(component, event, helper) {
        let index = event.currentTarget.dataset.index;
        let selectedProducts = component.get("v.selectedProducts");
        selectedProducts.splice(index, 1);
        component.set("v.selectedProducts", selectedProducts);
        
        helper.recalculateTotal(component, component.get('v.bill'), component.get('v.selectedProducts'));
    },

    minusAmount: function(component, event, helper) {
        let index = event.currentTarget.dataset.index;
        let selectedProducts = component.get("v.selectedProducts");
        selectedProducts[index].amount--;
        component.set("v.selectedProducts", selectedProducts);

        helper.recalculateTotal(component, component.get('v.bill'), component.get('v.selectedProducts'));
    },

    plusAmount: function(component, event, helper) {
        let index = event.currentTarget.dataset.index;
        let selectedProducts = component.get("v.selectedProducts");
        selectedProducts[index].amount++;
        component.set("v.selectedProducts", selectedProducts);

        helper.recalculateTotal(component, component.get('v.bill'), component.get('v.selectedProducts'));
    },

    toggleCache: function(component, event) {
        component.set('v.bill.isCache', event.currentTarget.dataset.cachevalue === 'true');
    }
})