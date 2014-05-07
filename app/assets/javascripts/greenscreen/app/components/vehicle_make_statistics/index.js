define(function(require, exports, module) {
  "use strict";

  module.exports = {
    Model: require("./model"),
    Views: {
      Display: require("./display/view")
    }
  };
});
