import { LightningElement, track } from 'lwc';

export default class AmountInput extends LightningElement {
    @track amount = 1;

    handleChange() {
        this.dispatchEvent(
            new CustomEvent('change', {detail: this.amount})
        );
    }

    get singleAmount() {
        return this.amount == 1;
    }

    increment() {
        this.amount++;
        this.handleChange();
    }

    decrement() {
        this.amount--;
        this.handleChange();
    }
}