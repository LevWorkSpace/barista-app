import { LightningElement, wire, api, track } from 'lwc';
import getProductsBySection from '@salesforce/apex/ProductSelectorController.getProductsBySection';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import PRODUCT_INFO from '@salesforce/schema/Product__c';
import PRODUCT_TYPES_FIELD from '@salesforce/schema/Product__c.Type__c';

export default class ProductSelector extends LightningElement {

    @track open = false;
    @track selectedSection;

    @wire(getProductsBySection) products;

    @wire(getObjectInfo, {objectApiName: PRODUCT_INFO}) productInfo;
    @wire(getPicklistValues, {recordTypeId: '$productInfo.data.defaultRecordTypeId', fieldApiName: PRODUCT_TYPES_FIELD})
        productSections;

    get selectedSectionName() {
        return this.selectedSection ? this.selectedSection : this.productSections.data.values[0].label;
    }

    get selectedSectionProducts() {
        return this.products.data[this.selectedSectionName] ? this.products.data[this.selectedSectionName] : [];
    }

    @api openSearch() {
        this.open = true;
    }

    closeSearch() {
        this.open = false;
    }

    handleProductSelected(event) {
        this.dispatchEvent(
            new CustomEvent('productselected', {detail: event.detail})
        );
    }

    handleSectionSelected(event) {
        this.selectedSection = event.detail;
    }

    get isOpen() {
        return this.open ? '' : 'slds-hide';
    }
}