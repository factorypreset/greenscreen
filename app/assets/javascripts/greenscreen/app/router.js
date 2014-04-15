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
  module.exports = Backbone.Router.extend({

    initialize: function() {
      this.vehicleMakes = new VehicleMake.Collection();
      this.vehicleMake = new VehicleMake.Model();
      this.vehicleModels = new VehicleModel.Collection();
      this.vehicleModel = new VehicleModel.Model();

      // configure layout and views
      var Layout = Backbone.Layout.extend({
        el: "main",
        template: require("ldsh!./templates/main"),
        views: {
          ".vehicle-makes": new VehicleMake.Views.List({ collection: this.vehicleMakes }),
          ".vehicle-models": new VehicleModel.Views.List({ collection: this.vehicleModels }),
          ".vehicle-model": new VehicleModel.Views.Display({ model: this.vehicleModel})
        }
      });

      // render page
      new Layout().render();

    },


    routes: {
      "": "index",
      "vehicle-makes": "vehicleMakeList",
      "vehicle-makes/make/:id": "vehicleMake",
      "vehicle-models": "vehicleModelList",
      "vehicle-models/model/:id": "vehicleModel",
      "vehicle-models/by-make/:make": "vehiclesByMake"
    },

    index: function() {
      this.vehicleMakes.fetch();
      this.reset();
    },

    vehicleMakeList: function() {
      this.vehicleMakes.fetch();
      // this.reset();
    },

    vehicleMake: function(id) {
      // fetch all vehicle makes if not already loaded
      if (this.vehicleMakes.length == 0) {
        this.vehicleMakes.fetch();
      }

      // get details for this one model
      this.vehicleModel.id = id;
      this.vehicleModel.fetch();
    },

    vehicleModelList: function() {
      this.vehicleModels.fetch();
      this.reset();
    },

    vehicleModel: function(id) {
      // fetch all vehicle models if not already loaded
      if (this.vehicleModels.length == 0) {
        this.vehicleModels.fetch();
      }

      // get details for this one model
      this.vehicleModel.id = id;
      this.vehicleModel.fetch();
    },

    vehiclesByMake: function(make) {
      this.vehicleModels.fetch({ data: { make: make } });
      this.reset();
    },

    reset: function() {
      if (this.vehicleModels.length) {
        this.vehicleModels.reset();
      }

      app.active = false;
    }
  });
});
