http = require 'http'
Negotiator = require 'negotiator'

Data = require './data.coffee'
db = require './database.coffee'
Q = require 'q'

require '../util/configuration.coffee'

availableMediaTypes = ['application/json']

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  if type == 'application/json'
    # TODO: move this to firebase
    data = new Data
    if request.url in ['/posts', '/posts/']
      Q.spawn ->
        posts = yield data.updatePosts()
        response.setHeader "Access-Control-Allow-Origin", "*"
        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify data.posts()
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)$/.exec request.url
      Q.spawn ->
        slug = match[1]
        yield data.updatePost slug
        response.setHeader "Access-Control-Allow-Origin", "*"
        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify data.post slug
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)\/comments$/.exec request.url
      Q.spawn ->
        slug = match[1]
        yield data.updatePost slug
        response.setHeader "Access-Control-Allow-Origin", "*"
        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify data.commentsForSlug slug

server.listen process.env.API_PORT
