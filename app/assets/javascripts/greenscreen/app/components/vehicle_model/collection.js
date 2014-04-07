define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Collection = Backbone.Collection.extend({
    url: function() {
      return app.api + "vehicle_models/" + this.id;
    }
  });

  module.exports = Collection;
});