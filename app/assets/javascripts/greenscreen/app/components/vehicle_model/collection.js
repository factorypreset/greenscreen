define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var VehicleModel = require("./model");

  var Collection = Backbone.Collection.extend({

    model: VehicleModel,

    url: function() {
      var uri = app.api + "vehicle-makes/" + this.vehicleMakeId + "/vehicle-models.json";
      return uri;
    }
  });

  module.exports = Collection;
});
