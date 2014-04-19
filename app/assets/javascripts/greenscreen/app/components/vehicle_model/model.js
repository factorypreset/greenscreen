define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Model = Backbone.Model.extend({

    // set some default attributes
    defaults: {
      'air_pollution_score_min': 0,
      'air_pollution_score_max': 10,
      'air_pollution_score_percentage': 0,
      'greenhouse_gas_score_min': 0,
      'greenhouse_gas_score_max': 10,
      'greenhouse_gas_score_percentage': 0,
      'city_mpg_min': 0,
      'city_mpg_max': 150,
      'city_mpg_percentage': 0,
      'hwy_mpg_min': 0,
      'hwy_mpg_max': 150,
      'hwy_mpg_percentage': 0,
      'combined_mpg_min': 0,
      'combined_mpg_max': 150,
      'combined_mpg_percentage': 0
    },

    initialize: function() {
      this.selected = false;
    },

    url: function() {
      return app.api + 'vehicle-makes/' + this.vehicleMakeId +
             '/vehicle-models/' + this.id + ".json";
    },

    select: function() {
      this.selected = true;
    },

    calculateProgress: function() {
      // TODO: DRY this up a little
      this.set({
        air_pollution_score_percentage: (this.get('air_pollution_score') / this.get('air_pollution_score_max')) * 100,
        greenhouse_gas_score_percentage: (this.get('greenhouse_gas_score') / this.get('greenhouse_gas_score_max')) * 100,
        city_mpg_percentage: (this.get('city_mpg') / this.get('city_mpg_max')) * 100,
        hwy_mpg_percentage: (this.get('hwy_mpg') / this.get('hwy_mpg_max')) * 100,
        combined_mpg_percentage: (this.get('combined_mpg') / this.get('combined_mpg_max')) * 100,
      });
    }
  });

  module.exports = Model;
});
