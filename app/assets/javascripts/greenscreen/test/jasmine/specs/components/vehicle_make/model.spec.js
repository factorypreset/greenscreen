define(function(require) {
  "use strict";

  var VehicleMake = require('components/vehicle_make/model');

  describe("selected attribute", function() {
    beforeEach(function() {
      this.vehicleMake = new VehicleMake;
    });

    afterEach(function() {
      this.vehicleMake = undefined;
    });

    it("is unselected by default", function() {
      expect(this.vehicleMake.selected).toBeFalsy();
    });

    it("can be selected", function() {
      this.vehicleMake.select();
      expect(this.vehicleMake.selected).toBeTruthy();
    })

  });

});