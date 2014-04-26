define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    tagName: "li",

    serialize: function() {
      return { make: this.model };
    },

    events: {
      click: "changeVehicleMake"
    },

    changeVehicleMake: function(ev) {
      this.emphasize();
      var nextUri = "vehicle-makes/" + this.model.id;
      app.router.navigate(nextUri, {trigger: true});
    },

    initialize: function() {
      if (this.model.selected) {
        this.emphasize();
      }
      this.listenTo(this.model, "change", this.render);
    },

    emphasize: function() {
      $(this.el.parentNode).children(".emphasis").removeClass("emphasis");
      this.$el.addClass("emphasis");
    }
  });

  module.exports = Layout;
});
