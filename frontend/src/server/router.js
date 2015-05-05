var Router, ServerRouter,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  slice = [].slice;

Router = require('../router');

ServerRouter = (function(superClass) {
  extend(ServerRouter, superClass);

  function ServerRouter() {
    return ServerRouter.__super__.constructor.apply(this, arguments);
  }

  ServerRouter.prototype.navigate = function(url, options) {
    var args, match, ref, regex, results, route;
    ref = this.routeRegexes();
    results = [];
    for (route in ref) {
      regex = ref[route];
      match = regex.exec(url);
      if (match) {
        args = match.slice(1);
        results.push(this[route].apply(this, slice.call(args).concat([options])));
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  return ServerRouter;

})(Router);

module.exports = ServerRouter;
