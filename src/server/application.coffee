http = require 'http'
Negotiator = require 'negotiator'

require '../util/configuration.coffee'

Data = require '../data.coffee'
View = require './view.coffee'
Router = require './router.coffee'

availableMediaTypes = ['text/html']

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  if type == 'text/html'
    router = new Router new Data, View
    router.navigate request.url, {'response': response }

server.listen process.env.WEB_PORT
