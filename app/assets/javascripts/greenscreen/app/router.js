define(function(require, exports, module) {
  "use strict";

  // External dependencies.
  var Backbone = require("backbone");
  var VehicleModel = require("components/vehicle_model/index");
  // var VehicleMake = require("components/vehicle_make/index");

  // Defining the application router.
  module.exports = Backbone.Router.extend({

    initialize: function() {
      this.vehicleModels = VehicleModel.Collection();
      // this.vehicleMakes = VehicleMake.Collection();
    },


    routes: {
      "": "index",
      "vehicle-model": "vehicleModel"
    },

    index: function() {
      console.log("Welcome to your / route.");
    },

    vehicleModel: function() {
      console.log("In teh vehicle model route.");
    }
  });
});
