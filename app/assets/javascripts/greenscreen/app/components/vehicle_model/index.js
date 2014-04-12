define(function(require, exports, module) {
  "use strict";

  module.exports = {
    Model: require("./model"),
    Collection: require("./collection"),
    Views: {
      Item: require("./item/view"),
      List: require("./list/view"),
      Display: require("./display/view")
    }
  };
});
