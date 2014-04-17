define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Model = Backbone.Model.extend({

    initialize: function() {
      this.selected = false;
    },

    url: function() {
      return app.api + "vehicle-models/" + this.id + ".json";
    },

    select: function() {
      this.selected = true;
    }
  });

  module.exports = Model;
});
