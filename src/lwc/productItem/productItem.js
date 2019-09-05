import { LightningElement, api, track } from 'lwc';
import noImage from '@salesforce/resourceUrl/NoImage';
import productPhotos from '@salesforce/resourceUrl/ProductPhoto';

export default class ProductItem extends LightningElement {
    @track backgroundImage;
    @api product;

    connectedCallback() {
        this.backgroundImage = 'background-image:url(' + (this.product.picture ? productPhotos + '/' + this.product.picture : noImage) + ')';
    }

    onProductClick(event) {
        this.animateSelection(event.currentTarget);
        this.dispatchEvent(
            new CustomEvent('productselected', {detail: Object.assign({}, this.product)})
        );
    }

    get productDescription() {
        return this.product.name + ' - ' + this.product.cost + '₴';
    }

    animateSelection(element) {
        element.classList.add('execute-selection-animation');
        element.addEventListener('animationend', function() {
            element.removeEventListener('animationend');
            element.classList.remove('execute-selection-animation');
        });
    }
}