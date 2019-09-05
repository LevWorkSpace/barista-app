import { LightningElement, api, track } from 'lwc';

export default class MessageBanner extends LightningElement {
    @track message = null;
    @track severity = '';
    @api duration = 1000;

    @api showMessage(message, severity) {
        this.message = message;
        this.severity = severity;
        this.template.querySelector('section').classList.add('visible');
        setTimeout(
            () => {
                this.template.querySelector('section').classList.remove('visible');
            },
            this.duration
        );
    }

    get iconName() {
        return "utility:" + this.severity;
    }

    get bannerClass() {
        return "slds-notify slds-notify--alert slds-theme--alert-texture slds-banner slds-theme--" + this.severity;
    }
}