define(function(require) {
  "use strict";

  var ItemLayout = require('components/vehicle_make/item/view');
  var VehicleMake = require('components/vehicle_make/model');

  describe("initialization", function() { 
    beforeEach(function() {
      this.make = new VehicleMake;
    });

    afterEach(function() {
      this.make = undefined;
    });

    it("does not emphasize the item by default", function() {
      this.layout = new ItemLayout( {
        model: this.make
      } );
      expect(this.layout.$el.hasClass("emphasis")).toBeFalsy();
    });

    it("emphasizes the item when it's selected", function() {
      this.make.select();
      this.layout = new ItemLayout( {
        model: this.make
      } );
      expect(this.layout.$el.hasClass("emphasis")).toBeTruthy();
    });

  });

});