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
      var nextPage = "model/" + this.model.id;
      app.router.navigate(nextPage, {trigger: true});
    },

    initialize: function() {
      this.listenTo(this.model, "change", this.render);
    }
  });

  module.exports = Layout;
});