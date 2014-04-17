define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Model = Backbone.Model.extend({
    url: function() {
      return app.api + 'vehicle-models/' + this.id + ".json";
    }
  });

  module.exports = Model;
});