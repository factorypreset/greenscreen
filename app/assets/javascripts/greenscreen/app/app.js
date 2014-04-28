define(function(require, exports, module) {
  "use strict";

  // External dependencies.
  var _ = require("underscore");
  var $ = require("jquery");
  var Backbone = require("backbone");
  var Layout = require("layoutmanager");

  // Alias the module for easier identification.
  var app = module.exports;

  // The root path to run the application through.
  app.root = "/";

  // API address
  // FIXME: remove localhost
  app.api = "http://localhost:3000/";

  // patch Collection to indicate when request is in progress
  _.extend(Backbone.Collection.prototype, {
    cache: true,

    initialize: function(models, options) {
      // Automatically extend in passed options.
      _.extend(this, options);

      // Listen for request and sync events to control the `isRequest` flag.
      this.on({
        request: function() {
          this.isRequest = true;
        },

        sync: function() {
          this.isRequest = false;
        }
      });

      // By default the collection is not in a request.
      this.isRequest = false;
    },

  });
});
