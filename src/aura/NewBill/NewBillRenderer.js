({
    afterRender: function (component, helper) {
         this.superAfterRender();
         component.find("disablePullEvent").getElement().addEventListener(
              "touchmove",
              helper.scrollStopPropagation,
              true // we use capture!
         );
    }
})