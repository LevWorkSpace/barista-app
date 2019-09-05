import { LightningElement, track, api } from 'lwc';

export default class SelectableSection extends LightningElement {

    @api selectedName;
    @api name;

    handleClick() {
        this.dispatchEvent(
            new CustomEvent('sectionselected', {detail: this.name})
        );
    }

    get isSelected() {
        return this.selectedName == this.name;
    }

    get variant() {
        return this.isSelected ? 'inverse' : 'brand';
    }

    get buttonClass() {
        return 'slds-size_1-of-1 slds-button_stateful slds-p-around--small title-caps '
                + (this.isSelected ? 'slds-button--success' : 'slds-is-not-selected');
    }

    get iconName() {
        return this.isSelected ? 'utility:check' : 'utility:search';
    }
}