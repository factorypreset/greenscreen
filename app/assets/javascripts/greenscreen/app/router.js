define(function(require, exports, module) {
  "use strict";

  // External dependencies.
  var Backbone = require("backbone");

  // Load the app
  var app = require("app");

  // Greenscreen components
  var VehicleMake = require("components/vehicle_make/index");
  var VehicleModel = require("components/vehicle_model/index");

  // Defining the application router.
  var Router = Backbone.Router.extend({

    initialize: function(options) {
      if (typeof(options) === "undefined") {
        options = { renderLayout: true };
      }

      this.vehicleMakes = new VehicleMake.Collection();
      this.vehicleMake = new VehicleMake.Model();
      this.vehicleModels = new VehicleModel.Collection();
      this.vehicleModel = new VehicleModel.Model();

      var Layout = Backbone.Layout.extend({
        el: "main",
        template: require("ldsh!./templates/main"),
        views: {
          ".vehicle-makes": new VehicleMake.Views.List({ collection: this.vehicleMakes }),
          ".vehicle-models": new VehicleModel.Views.List({ collection: this.vehicleModels }),
          ".vehicle-model": new VehicleModel.Views.Display({ model: this.vehicleModel})
        }
      });

      // render this if required
      if (options.renderLayout) {
        new Layout().render();
      }

    },

    routes: {
      "": "indexRoute",
      "vehicle-makes": "vehicleMakeListRoute",
      "vehicle-makes/:vehicleMakeId": "vehicleMakeRoute",
      "vehicle-makes/:vehicleMakeId/vehicle-models": "vehicleModelListRoute",
      "vehicle-makes/:vehicleMakeId/vehicle-models/:vehicleModelId": "vehicleModelRoute"
    },

    indexRoute: function() {
      this.vehicleMakes.fetch();
      this.reset();
    },

    vehicleMakeListRoute: function() {
      this.vehicleMakes.fetch();
    },

    vehicleMakeRoute: function(vehicleMakeId) {
      // fetch all vehicle makes if not already loaded
      if (this.vehicleMakes.length == 0) {
        this.vehicleMakes.fetch({
          success: function(results) {
            var selectedItem = results.get(vehicleMakeId);
            selectedItem.select();
          }
        });
      }

      // get all vehicle models for this make
      this.vehicleModels.vehicleMakeId = vehicleMakeId;
      this.vehicleModels.fetch();

      // clear out model details
      this.vehicleModel.clear();
    },

    vehicleModelListRoute: function(vehicleMakeId) {
      // get all the models for this make
      this.vehicleModels.vehicleMakeId = vehicleMakeId;
      this.vehicleModels.fetch();
      this.reset();
    },

    vehicleModelRoute: function(vehicleMakeId, vehicleModelId) {
      // fetch all vehicle makes if not already loaded
      if (this.vehicleMakes.length == 0) {
        this.vehicleMakes.fetch({
          success: function(results) {
            var selectedItem = results.get(vehicleMakeId);
            selectedItem.select();
          }
        });
      }

      // fetch all vehicle models for the given make
      // (if not already loaded)
      if (this.vehicleModels.length == 0) {
        this.vehicleModels.vehicleMakeId = vehicleMakeId;
        this.vehicleModels.fetch({
          success: function(results) {
            var selectedItem = results.get(vehicleModelId);
            selectedItem.select();
          }
        });
      }

      // get details for this one model
      this.vehicleModel.id = vehicleModelId;
      this.vehicleModel.vehicleMakeId = vehicleMakeId;
      this.vehicleModel.fetch();
    },

    reset: function() {
      if (this.vehicleModels.length) {
        this.vehicleModels.reset();
      }

      if (this.vehicleModel.length) {
        this.vehicleModel.reset();
      }

      if (this.vehicleMakes.length) {
        this.vehicleMakes.reset();
      }

      app.active = false;
    }

  });

  module.exports = Router;

});
