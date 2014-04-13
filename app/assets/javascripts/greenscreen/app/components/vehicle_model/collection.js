define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Collection = Backbone.Collection.extend({
    // model: needed? unsure.
    url: function() {
      var uri = app.api + "vehicle-models.json";
      return uri;
    }
  });

  module.exports = Collection;
});