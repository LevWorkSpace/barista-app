import { LightningElement, track } from 'lwc';
import saveBill from '@salesforce/apex/NewBillController.saveBillWithProducts';
import getPreviousBill from '@salesforce/apex/NewBillController.getPreviousBill';
import stylesheet from '@salesforce/resourceUrl/billContainerStylesheet';
import { loadStyle } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class BillContainer extends LightningElement {

    ALLOWED_CHARACTERS_FOR_RANDOM_KEY = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    START_OFFSET_FOR_OLD_BILL = -1;
    MAX_OFFSET_FOR_OLD_BILL = 10;
    PRODUCT_DISCOUNT = [
        {value : 0, label : "0%"},
        {value : 10, label : "10%"},
        {value : 50, label : "50%"},
        {value : 100, label : "free"}
    ];
    BILL_DISCOUNT = [
        {value : 0, label : "0%"},
        {value : 30, label : "30%"}
    ];

    @track oldBill;
    @track cash;
    @track selectedProducts = [];
    @track bill = {'totalPrice' : 0, 'discount' : 0, 'totalPriceWithDiscount' : 0, 'isCash' : null};
    @track showSpinner = false;

    oldBillOffset = this.START_OFFSET_FOR_OLD_BILL;

    constructor() {
        super();
        loadStyle(this, stylesheet);
    }

    loadNextBill() {
        this.oldBillOffset--;
        this.loadBill();
    }

    loadPreviousBill() {
        this.oldBillOffset++;
        this.selectedProducts = [];
        this.loadBill();
    }

    loadBill(shift) {
        this.message = null;
        this.showSpinner = true;
        getPreviousBill({offsetValue: this.oldBillOffset})
            .then(result => {
                this.oldBill = result;
            })
            .catch(error => {
                this.template.querySelector('c-message-banner').showMessage(error.body ? error.body.message : error, 'error');
            })
            .finally(() => {
                this.showSpinner = false;
            });
    }

    renderedCallback() {
        this.addEventListener(
             "touchmove",
             e => {e.stopPropagation();}
         );
    }

    openProductSearch() {
        this.template.querySelector('c-product-selector').openSearch();
    }

    handleProductSelected(event) {
        let product = event.detail;
        product.discount = 0;
        product.amount = 1;
        product.totalCost = Math.round(product.amount * product.cost * (100 - product.discount)/100);
        product.key = this.generateRandomKey();
        this.selectedProducts.push(product);
        this.recalculateTotal();
    }

    handleProductDiscountSelected(event) {
        let product = this.selectedProducts[event.currentTarget.dataset.index];
        product.discount = event.detail;
        product.totalCost = Math.round(product.amount * product.cost * (100 - product.discount)/100);
        this.recalculateTotal();
    }

    handleBillDiscountSelected(event) {
        this.bill.discount = event.detail;
        this.bill.totalPriceWithDiscount = this.bill.totalPrice * (100 - this.bill.discount)/100;
    }

    handleAmountChanged(event) {
        let index = event.currentTarget.dataset.index;
        let amount = event.detail;
        if (amount == 0) {
            this.selectedProducts.splice(index, 1);
        } else {
            let product = this.selectedProducts[index];
            product.amount = amount;
            product.totalCost = Math.round(product.amount * product.cost * (100 - product.discount)/100);
        }
        this.recalculateTotal();
    }

    recalculateTotal() {
        this.bill.totalPrice = this.selectedProducts.reduce(
            (total, product) => {
                return total + product.totalCost;
            }, 0
        );
        this.bill.totalPriceWithDiscount = this.bill.totalPrice * (100 - this.bill.discount)/100;
    }

    saveBill() {
        this.showSpinner = true;
        saveBill({
            bill: this.buildBill(),
            billProducts: this.buildBillProducts()
        })
        .then(result => {
            this.clearView();
            this.template.querySelector('c-message-banner').showMessage('The Bill was created.', 'success');
        })
        .catch(error => {
            this.template.querySelector('c-message-banner').showMessage(error.body ? error.body.message : error, 'error');
        })
        .finally(() => {
            this.showSpinner = false;
        });
    }

    buildBill() {
        return {
            TotalPrice__c : this.bill.totalPrice,
            Discount__c : this.bill.discount,
            PaymentMethod__c : this.bill.isCash ? 'Cash' : 'Card'
        }
    }

    buildBillProducts() {
        let billProducts = [];
        for (let i = 0; i < this.selectedProducts.length; i++) {
            let product = this.selectedProducts[i];
            billProducts.push({
                Name : product.name,
                Product__c : product.productId,
                Amount__c : product.amount,
                Discount__c : product.discount,
                TotalCost__c : product.totalCost
            });
        }
        return billProducts;
    }

    get billIsNotReady() {
        return this.spinner || this.bill.isCash == null;
    }

    clearView() {
        this.cash = null;
        this.selectedProducts = [];
        this.bill = {'totalPrice' : 0, 'discount' : 0, 'totalPriceWithDiscount' : 0, 'isCash' : null};
        this.oldBill = null;
        this.oldBillOffset = this.START_OFFSET_FOR_OLD_BILL;
    }

    toggleCash(event) {
        this.bill.isCash = event.currentTarget.dataset.cashvalue == 'true';
    }

    get cashVariant() {
        return this.bill.isCash == true ? 'success' : 'neutral';
    }

    get cardVariant() {
        return this.bill.isCash == false ? 'success' : 'neutral'
    }

    setChange(event) {
        this.cash = event.target.value;
    }

    get change() {
        return this.cash ? this.cash - this.bill.totalPriceWithDiscount : null;
    }

    generateRandomKey() {
        let result = '';
        for (let i = 0; i < 10; i++) {
           result += this.ALLOWED_CHARACTERS_FOR_RANDOM_KEY.charAt(Math.floor(Math.random() * this.ALLOWED_CHARACTERS_FOR_RANDOM_KEY.length));
        }
        return result;
    }

    get disableNextButton() {
        return this.oldBillOffset <= this.START_OFFSET_FOR_OLD_BILL + 1;
    }

    get disablePreviousButton() {
        return this.oldBillOffset >= this.MAX_OFFSET_FOR_OLD_BILL - 1;
    }
}