define(function(require) {
  "use strict";

  var ItemLayout = require("components/vehicle_model/item/view");
  var VehicleModel = require("components/vehicle_model/model");
  var app = require("app");

  describe("emphasis", function() { 
    beforeEach(function() {
      this.vehicleModel = new VehicleModel;
    });

    it("does not emphasize the item by default", function() {
      this.layout = new ItemLayout( {
        model: this.vehicleModel
      } );
      expect(this.layout.$el.hasClass("emphasis")).toBeFalsy();
    });

    it("emphasizes the item when it's selected", function() {
      this.vehicleModel.select();
      this.layout = new ItemLayout( {
        model: this.vehicleModel
      } );
      expect(this.layout.$el.hasClass("emphasis")).toBeTruthy();
    });
  });

  describe("changing vehicle models", function() {
    beforeEach(function() {
      this.testModelId = 99999;
      this.testMakeId = 88888;
      this.vehicleModel = new VehicleModel({
        id: this.testModelId,
        model: "A Test Vehicle",
        vehicle_make_id: this.testMakeId
      });

      this.layout = new ItemLayout({
        model: this.vehicleModel
      });

      // mock router.navigate() and spy on it
      this.layout.router = jasmine.createSpyObj(
        "router", ["navigate"]
      );
    });

    it("is called when the current model when clicked", function() {
      spyOn(this.layout, "changeVehicleModel");
      this.layout.render();

      $(this.layout.el).find("a.model-click").trigger("click");
      expect(this.layout.changeVehicleModel).toHaveBeenCalled();
    });

    it("emphasizes the current model when clicked", function() {
      spyOn(this.layout, "emphasize");
      this.layout.render();

      $(this.layout.el).find("a.model-click").trigger("click");
      expect(this.layout.emphasize).toHaveBeenCalled();
    });

    it("navigates to the selected model when clicked", function() {
      this.layout.render();
      var expectedNextUri = "vehicle-makes/" + this.testMakeId + "/vehicle-models/" + this.testModelId;

      $(this.layout.el).find("a.model-click").trigger("click");
      expect(this.layout.router.navigate).toHaveBeenCalledWith(expectedNextUri, {trigger: true});
    });
  });

});
