define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var VehicleMake = require("./model");

  var Collection = Backbone.Collection.extend({

    model: VehicleMake,

    url: function() {
      var uri = app.api + "vehicle-makes.json";
      return uri;
    }
  });

  module.exports = Collection;
});
