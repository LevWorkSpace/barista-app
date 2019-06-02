({
    handleSectionHeaderClick : function(component, event, helper) {
        component.set('v.state', !component.get('v.state'));
        var sectionContainer = component.find('collapsibleSectionContainer');
        $A.util.toggleClass(sectionContainer, "slds-is-open");
    }
})