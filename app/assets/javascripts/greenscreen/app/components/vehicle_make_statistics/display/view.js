define(function(require, exports, module) {
  "use strict";

  var app = require("app");
  var plot = require("jquery.flot");

  var Layout = Backbone.Layout.extend({

    minimum: 10,
    maximum: 20,

    template: require("ldsh!./template"),

    tagName: "div",

    serialize: function() {
      return { model: this.model };
    },

    minMpg: function(field) {
      var min = _.min(this.model.get(field));
      return min * 0.9;
    },

    maxMpg: function(field) {
      var max = _.max(this.model.get(field));
      return max * 1.1;
    },

    setMinMpg: function(field) {
      var fieldMin = this.minMpg(field);
      if (fieldMin < this.minimum) {
        this.minimum = fieldMin;
      }
    },

    setMaxMpg: function(field) {
      var fieldMax = this.maxMpg(field);
      if (fieldMax > this.maximum) {
        this.maximum = fieldMax;
      }
    },

    plotOptions: {
      series: {
        lines: { show: true },
        points: { show: false },
        shadowSize: 2
      },
      grid: {
        hoverable: true,
        clickable: true,
        autoHighlight: true
      },
      yaxis: { min: this.minimum, max: this.maximum },
      xaxis: { tickDecimals: 0 },
      legend: { position: "se" }
    },

    extractDataFromField: function(field) {
      var fieldData = _.map(this.model.get(field), function(val, yr) {
        if (val > 0) {
          // only include years with non-zero data
          return [yr, val];
        }
      });
      return fieldData;
    },

    extractDataFromFields: function(fields) {
      var data = [],
          fieldData = [],
          that = this;
      _.each(fields, function(field) {
        that.setMinMpg(field);
        that.setMaxMpg(field);
        fieldData = that.extractDataFromField(field);

        data.push( {
          data: fieldData,
          label: field
        } );
      });

      return data;
    },

    toolTipHtml: function(item, label) {
      var toolTipTemplate = require("ldsh!./tooltip");
      return toolTipTemplate({
        item: Number((item).toFixed(2)),
        label: label
      });
    },

    displayToolTip: function(item) {
      var tip, val, label;

      this.clearToolTips();

      if (item) {
        val = item.series.data[item.dataIndex][1];
        label = item.series.label;
        tip = $(this.toolTipHtml(val, label));
        this.$("#stats-placeholder").append(tip);

        tip.offset({
          left: item.pageX - 55,
          top: item.pageY - tip.outerHeight() - 15
        });
      }
    },

    clearToolTips: function() {
      this.$("#stats-placeholder .plot-tip").remove();
    },

    drawPlot: function(fields) {
      var data = this.extractDataFromFields(fields),
          options = this.plotOptions,
          p = plot(this.$("#stats-placeholder"), data, options),
          that = this;

      // listen for events on the plot points
      this.$("#stats-placeholder").on("plothover", function(event, pos, item) {
        that.displayToolTip(item);
      });
    },

    initialize: function() {
      var view = this;
      this.listenTo(this.model, "change", function(e) {
        view.render();
        view.drawPlot( ["city_mpg", "hwy_mpg", "combined_mpg"] );
      });
    }

  });

  module.exports = Layout;
});
