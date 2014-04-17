define(function(require, exports, module) {
  "use strict";

  var app = require("app");

  var Layout = Backbone.Layout.extend({
    template: require("ldsh!./template"),

    tagName: "li",

    serialize: function() {
      return { model: this.model };
    },

    events: {
      click: "changeVehicleModel"
    },

    changeVehicleModel: function(ev) {
      this.emphasize();
      var vehicleMakeId = this.model.get('vehicle_make_id');
      var nextUri = "vehicle-makes/" + vehicleMakeId + "/vehicle-models/" + this.model.id;
      app.router.navigate(nextUri, {trigger: true});
    },

    initialize: function() {
      this.listenTo(this.model, "change", this.render);
    },

     emphasize: function() {
      $(this.el.parentNode).children(".emphasis").removeClass("emphasis");
      this.$el.addClass("emphasis");
    }
  });

  module.exports = Layout;
});
