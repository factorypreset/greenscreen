define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var Item = require("../item/view");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    serialize: function() {
      return { vehicleModels: this.collection };
    },

    beforeRender: function() {
      this.collection.each(function(vehicleModel) {
        this.insertView(".vehicle-model-list", new Item({
          model: vehicleModel
        }));
      }, this);
    },

    afterRender: function() {
      // Only re-focus if invalid.
      this.$("input.invalid").focus();
    },

    initialize: function() {
      // Whenever the collection resets, re-render.
      this.listenTo(this.collection, "reset sync request", this.render);
    },

    events: {
      "submit form": "updateYear"
    },

    updateYear: function(ev) {
      app.router.go("vehicle-model", this.$(".year").val());

      return false;
    }
  });

  module.exports = Layout;
});