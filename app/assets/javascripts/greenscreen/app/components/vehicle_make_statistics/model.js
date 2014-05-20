define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Model = Backbone.Model.extend({

    url: function() {
      var uri = app.api + "vehicle-makes/";
      if (_.isUndefined(this.vehicleMakeId)) {
        uri += "statistics.json";
      } else {
        uri += this.vehicleMakeId + "/statistics.json";
      }

      return uri;
    },

    parse: function(response, xhr) {
      var yr;

      // convert mpg values into floats
      for (yr in response.city_mpg) {
        response.city_mpg[yr] = parseFloat(response.city_mpg[yr]);
      }

      for (yr in response.hwy_mpg) {
        response.hwy_mpg[yr] = parseFloat(response.hwy_mpg[yr]);
      }

      for (yr in response.combined_mpg) {
        response.combined_mpg[yr] = parseFloat(response.combined_mpg[yr]);
      }

      return response;
    }

  });

  module.exports = Model;
});
