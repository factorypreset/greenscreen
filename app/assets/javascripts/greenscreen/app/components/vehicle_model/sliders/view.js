define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    serialize: function() {
      return { vehicleModels: this.collection };
    },

    beforeRender: function() {
    },

    afterRender: function() {
    },

    initialize: function() {
      // Whenever the collection resets, re-render.
      // this.listenTo(this.collection, "reset sync request", this.render);
    },

  });

  module.exports = Layout;
});
