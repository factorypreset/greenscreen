define(function(require) {
  "use strict";

  var VehicleModel = require('components/vehicle_model/model');

  describe("selected attribute", function() {
    beforeEach(function() {
      this.vehicleModel = new VehicleModel;
    });

    afterEach(function() {
      this.VehicleModel = undefined;
    });

    it("is unselected by default", function() {
      expect(this.vehicleModel.selected).toBeFalsy();
    });

    it("can be selected", function() {
      this.vehicleModel.select();
      expect(this.vehicleModel.selected).toBeTruthy();
    });

  });

});