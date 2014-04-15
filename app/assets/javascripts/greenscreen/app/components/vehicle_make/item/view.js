define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    tagName: "li",

    serialize: function() {
      return { model: this.model };
    },

    events: {
      click: "changeVehicleMake"
    },

    changeVehicleMake: function(ev) {
      this.emphasize();
      var nextPage = "vehicle-models/by-make/" + this.model.get("make");
      app.router.navigate(nextPage, {trigger: true});
    },

    initialize: function() {
      this.listenTo(this.model, "change", this.render);
    },

    emphasize: function() {
      $(this.el.parentNode).children(".emphasis").removeClass("emphasis");
      this.$el.addClass("emphasis");
    }
  });

  module.exports = Layout;
});
