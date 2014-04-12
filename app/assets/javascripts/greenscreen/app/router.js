define(function(require, exports, module) {
  "use strict";

  // External dependencies.
  var Backbone = require("backbone");

  // Load the app
  var app = require("app");

  // Greenscreen components
  var VehicleModel = require("components/vehicle_model/index");
  // var VehicleMake = require("components/vehicle_make/index");

  // Defining the application router.
  module.exports = Backbone.Router.extend({

    initialize: function() {
      this.vehicleModels = new VehicleModel.Collection();
      this.vehicleModel = new VehicleModel.Model();

      // configure layout and views
      var Layout = Backbone.Layout.extend({
        el: "main",
        template: require("ldsh!./templates/main"),
        views: {
          ".vehicle-models": new VehicleModel.Views.List({ collection: this.vehicleModels}),
          ".vehicle-model": new VehicleModel.Views.Display({ model: this.vehicleModel})
        }
      });

      // render page
      new Layout().render();

    },


    routes: {
      "": "index",
      "vehicles-by-make/:make": "vehiclesByMake",
      "vehicle-model/:id": "vehicleModel"
    },

    index: function() {
      console.log("index routese");
      this.vehicleModels.fetch();
      this.reset();
    },

    vehiclesByMake: function(make) {
      console.log("vehicles-by-make route");
      console.log("called vehiclesByMake with", make);
      this.vehicleModels.fetch({ data: { make: make } });
      this.reset();
    },

    vehicleModel: function(id) {
      console.log("vehicle-model route!!!");
      this.vehicleModel.id = id;
      this.vehicleModel.fetch();
      this.reset();
      // vehicleModel route tbc....
    },

    reset: function() {
      if (this.vehicleModels.length) {
        this.vehicleModels.reset();
      }

      app.active = false;
    }
  });
});
