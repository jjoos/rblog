var http = require('http');
var Negotiator = require('negotiator');
var Dispatcher = require('../dispatcher');
var Router = require('./router');

require('src/util/configuration');
require('./navigation');

process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0;

var server = http.createServer(function(request, response) {
  var negotiator, router, type;
  negotiator = new Negotiator(request);
  type = negotiator.mediaType(['text/html']);
  if (type === 'text/html') {
    router = new Router(new Dispatcher);
    return router.navigate(request.url, {
      'response': response
    });
  }
});

server.listen(process.env.WEB_PORT);
