define("container", function(require) {
  var app = require("app");
  var Router = require("router");

  var Backbone = require("backbone");
  var $ = require("jquery");

  app.router = new Router();

  Backbone.history.start({ pushState: true, root: app.root });

  $(document).on("click", "a[href]:not([data-bypass])", function(evt) {
    var href = { prop: $(this).prop("href"), attr: $(this).attr("href") };
    var root = location.protocol + "//" + location.host + app.root;

    if (href.prop.slice(0, root.length) === root) {
      evt.preventDefault();
      Backbone.history.navigate(href.attr, true);
    }
  });
});

require(["config"], function() {
  require(["container"]);
});