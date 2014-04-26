define(function(require) {
  "use strict"

  var app = require("app");
  var Router = require("router");

  describe("Greenscreen route resolution", function() {
    beforeEach(function() {

      // Stop history so we can spy on routes
      Backbone.history.stop();

      // Spy on the routes
      spyOn(Router.prototype, "indexRoute");
      spyOn(Router.prototype, "vehicleMakeListRoute");
      spyOn(Router.prototype, "vehicleMakeRoute");
      spyOn(Router.prototype, "vehicleModelListRoute");
      spyOn(Router.prototype, "vehicleModelRoute");

      // instantiate router but don't render it
      this.router = new Router({
        renderLayout: false
      });

      // Start history now that spies are defined
      Backbone.history.start({
        pushState: true,
        root: app.root
      });

      this.nullCallback = null;

    });

    it("can resolve the index route", function() {
      this.router.navigate("", { trigger: true });
      expect(this.router.indexRoute).toHaveBeenCalled();
    });

    it("can resolve the vehicleMakeList route", function() {
      this.router.navigate("vehicle-makes", { trigger: true });
      expect(this.router.vehicleMakeListRoute).toHaveBeenCalled();
    });

    it("can resolve the vehicleMake route", function() {
      this.router.navigate("vehicle-makes/9999", { trigger: true });
      expect(this.router.vehicleMakeRoute).toHaveBeenCalledWith("9999", this.nullCallback);
    });

    it("can resolve the vehicleModelList route", function() {
      this.router.navigate("vehicle-makes/999/vehicle-models", { trigger: true });
      expect(this.router.vehicleModelListRoute).toHaveBeenCalledWith("999", this.nullCallback);
    });

    it("can resolve the vehicleModel router", function() {
      this.router.navigate("vehicle-makes/999/vehicle-models/888", { trigger: true });
      expect(this.router.vehicleModelRoute).toHaveBeenCalledWith("999", "888", this.nullCallback);
    });

  });

  describe("controlling data access via routes", function() {
    beforeEach(function() {

      // instantiate router but don't render it
      this.router = new Router({
        renderLayout: false
      });

    });

    it("can fetch all the makes via the index route", function() {
      spyOn(this.router.vehicleMakes, "fetch");

      this.router.navigate("", { trigger: true} );
      expect(this.router.vehicleMakes.fetch).toHaveBeenCalled();
    });

    it("can fetch all the makes via the vehicleMakeList route", function() {
      spyOn(this.router.vehicleMakes, "fetch");

      this.router.navigate("vehicle-makes", { trigger: true });
      expect(this.router.vehicleMakes.fetch).toHaveBeenCalled();
    });

    it("can fetch models for the given make via the vehicleMake route", function() {
      spyOn(this.router.vehicleModels, "fetch");

      this.router.navigate("vehicle-makes/9999", { trigger: true });
      expect(this.router.vehicleModels.vehicleMakeId).toEqual("9999");
      expect(this.router.vehicleModels.fetch).toHaveBeenCalled();
    });

    it("can fetch models for the given make via the vehicleModelList route", function() {
      spyOn(this.router.vehicleModels, "fetch");

      this.router.navigate("vehicle-makes/999/vehicle-models", { trigger: true });
      expect(this.router.vehicleModels.vehicleMakeId).toEqual("999");
      expect(this.router.vehicleModels.fetch).toHaveBeenCalled();
    });

    it("can fetch details for a given make and model", function() {
      spyOn(this.router.vehicleMakes, "fetch");
      spyOn(this.router.vehicleModels, "fetch");
      spyOn(this.router.vehicleModel, "fetch");

      this.router.navigate("vehicle-makes/999/vehicle-models/111", { trigger: true });
      expect(this.router.vehicleMakes.fetch).toHaveBeenCalled();
      expect(this.router.vehicleModels.fetch).toHaveBeenCalled();
      expect(this.router.vehicleModels.vehicleMakeId).toEqual("999");
      expect(this.router.vehicleModel.fetch).toHaveBeenCalled();
    });

  });
});
