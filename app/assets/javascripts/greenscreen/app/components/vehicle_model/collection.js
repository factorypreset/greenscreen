define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Collection = Backbone.Collection.extend({
    url: function() {
      var uri = app.api + "vehicle_models.json?make=Tesla";
      console.log(uri);
      return uri;
    }
  });

  module.exports = Collection;
});