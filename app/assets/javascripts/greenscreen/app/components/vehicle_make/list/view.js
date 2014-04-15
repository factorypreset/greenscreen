define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var Item = require("../item/view");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    serialize: function() {
      return { vehicleMakes: this.collection };
    },

    beforeRender: function() {
      this.collection.each(function(vehicleMake) {
        this.insertView(".vehicle-make-list", new Item({
          model: vehicleMake
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
    },

  });

  module.exports = Layout;
});
