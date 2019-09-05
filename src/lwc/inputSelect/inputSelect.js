import { LightningElement, api } from 'lwc';

export default class InputSelect extends LightningElement {
    @api options;

    handleChange(event) {
        this.dispatchEvent(
            new CustomEvent('change', {detail: event.target.value})
        );
    }
}