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
      var nextPage = "vehicle-models/by-make/" + this.model.get("make");
      app.router.navigate(nextPage, {trigger: true});
    },

    initialize: function() {
      this.listenTo(this.model, "change", this.render);
    }
  });

  module.exports = Layout;
});
