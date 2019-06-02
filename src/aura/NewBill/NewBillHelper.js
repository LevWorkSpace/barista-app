({
    addProduct: function(component, product) {
        product.discount = 0;
        product.amount = 1;
        product.countTotal = function() {
            this.totalCost = Math.round(this.amount * this.cost * (100 - this.discount)/100);
        }
        product.countTotal();

        let selectedProducts = component.get('v.selectedProducts');
        selectedProducts.push(product);
        component.set('v.selectedProducts', selectedProducts);
    },

    recalculateTotal: function(component, bill, selectedProducts) {
        bill.totalPrice = 0;
        for (let i = 0; i < selectedProducts.length; i++) {
            selectedProducts[i].countTotal();
            bill.totalPrice += selectedProducts[i].totalCost;
        }
        bill.totalPriceWithDiscount = Math.round(bill.totalPrice * (100 - bill.discount)/100);
        component.set('v.bill', bill);
        component.set('v.selectedProducts', selectedProducts);
    },

    saveBill: function(component, bill, selectedProducts) {
        let action = component.get("c.saveBillWithProducts");
        action.setParam('bill', this.buildBill(bill));
        action.setParam('billProducts', this.buildBillProducts(selectedProducts));
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success",
                    "type" : "success",
                    "message": "The Bill was created."
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
            } else {
                this.handleErrors(response.getError());
            }
        });
        $A.enqueueAction(action);
    },

    buildBill: function(billWrapper) {
        return {
            TotalPrice__c : billWrapper.totalPrice,
            Discount__c : billWrapper.discount
        }
    },

    buildBillProducts: function(selectedProducts) {
        let billProducts = [];
        for (let i = 0; i < selectedProducts.length; i++) {
            billProducts.push({
                Name : selectedProducts[i].name,
                Product__c : selectedProducts[i].productId,
                Amount__c : selectedProducts[i].amount,
                Discount__c : selectedProducts[i].discount,
                TotalCost__c : selectedProducts[i].totalCost
            });
        }
        return billProducts;
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
    }
})