define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    tagName: "div",

    serialize: function() {
      return { model: this.model };
    },

    initialize: function() {
      this.listenTo(this.model, "sync", this.updateContent);
      this.listenTo(this.model, "change", this.render);
    },

    updateContent: function() {
      this.model.set(this.model.defaults);
      this.model.calculateProgress();
    }
  });

  module.exports = Layout;
});
