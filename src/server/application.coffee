http = require 'http'
Negotiator = require 'negotiator'

require '../util/configuration'

Dispatcher = require '../dispatcher'
Router = require './router'
require './navigation'

availableMediaTypes = ['text/html']

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  if type == 'text/html'
    router = new Router(new Dispatcher)
    router.navigate request.url, {'response': response }

server.listen process.env.WEB_PORT
