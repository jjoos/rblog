http = require 'http'
Negotiator = require 'negotiator'

require '../util/configuration.coffee'

Dispatcher = require '../dispatcher.coffee'
Router = require './router.coffee'
require './navigation.coffee'

availableMediaTypes = ['text/html']

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  if type == 'text/html'
    router = new Router(new Dispatcher)
    router.navigate request.url, {'response': response }

server.listen process.env.WEB_PORT
