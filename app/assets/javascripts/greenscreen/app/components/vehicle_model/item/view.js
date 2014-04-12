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
      click: "changeVehicleModel"
    },

    changeVehicleModel: function(ev) {
      app.router.navigate("vehicle-model/", this.model.id);
    },

    initialize: function() {
      this.listenTo(this.model, "change", this.render);
    }
  });

  module.exports = Layout;
});