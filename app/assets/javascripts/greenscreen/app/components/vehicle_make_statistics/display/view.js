define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var plot = require("jquery.flot");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    tagName: "div",

    serialize: function() {
      return { model: this.model };
    },

    minMpg: function(field) {
     var min = _.min(this.model.get(field));
     return (min - (min * 0.1));
    },

    maxMpg: function(field) {
      var max = _.max(this.model.get(field));
      return (max + (max * 0.1));
    },

    graph: function(fields) {
      var data = [],
          fieldData = [],
          that = this,
          minimum = 10,
          maximum = 20;

      _.each(fields, function(field) {
        var fieldMin = that.minMpg(field);
        var fieldMax = that.maxMpg(field);
        if (fieldMin < minimum) {
          minimum = fieldMin;
        }
        if (fieldMax > maximum) {
          maximum = fieldMax;
        }

        fieldData = _.map(that.model.get(field), function(val, yr) {
          if (val > 0) {
            return [yr, val];
          }
        });

        data.push( {
          data: fieldData,
          label: field
        } );

      });

      //data = [ data ];

      var options = {
        series: {
          lines: { show: true },
          points: { show: false },
          shadowSize: 5
        },
        yaxis: { min: minimum, max: maximum },
        xaxis: { tickDecimals: 0 },
        legend: { position: "se", margin: "20px" }
      };
      plot(this.$("#stats-placeholder"), data, options);
    },

    initialize: function() {
      // this.listenTo(this.model, "change", this.render);
      var view = this;
      this.listenTo(this.model, "change", function(e) {
        view.render();
        view.graph( ["city_mpg", "hwy_mpg", "combined_mpg"] );
      });
    }

  });

  module.exports = Layout;
});
