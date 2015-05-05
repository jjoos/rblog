var Dispatcher, Navigation, Q, React, fs, getTemplate,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Q = require('q');

React = require('react');

Navigation = require('../actions/navigation');

Dispatcher = require('../dispatcher');

fs = require('fs');

getTemplate = function(callback) {
  return fs.readFile('assets/template.html', {
    encoding: 'utf8'
  }, function(error, data) {
    if (error) {
      return console.log(error);
    }
    return callback(data);
  });
};

Dispatcher.registerActionClass((function(superClass) {
  extend(_Class, superClass);

  function _Class() {
    return _Class.__super__.constructor.apply(this, arguments);
  }

  _Class.prototype._render = function(action, getComponent, options) {
    if (action != null) {
      return Q.spawn((function(_this) {
        return function*() {
          (yield action());
          return _this._renderComponent(getComponent, options);
        };
      })(this));
    } else {
      return this._renderComponent(getComponent, options);
    }
  };

  _Class.prototype._renderComponent = function(getComponent, options) {
    return getTemplate(function(template) {
      var html;
      html = React.renderToString(getComponent());
      html = template.replace('<body />', "<body>" + html + "</body>");
      options.response.writeHead(200, {
        'Content-Type': 'text/html'
      });
      return options.response.end(html);
    });
  };

  return _Class;

})(Navigation));
