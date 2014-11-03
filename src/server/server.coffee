http = require 'http'
React = require 'react'
Negotiator = require 'negotiator'

View = require './view.coffee'
files = require './files.coffee'
Data = require './data.coffee'
Router = require './router.coffee'
db = require './database.coffee'
Q = require 'q'

_ = require 'underscore'
require './configuration.coffee'

availableMediaTypes =
  ['text/html', 'application/json'].concat files.supportedContentTypes

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  # 404 on favicon
  if request.url == '/favicon.ico'
    # TODO: move this to cdn or nginx
    response.writeHead 404
    response.end()
  else if type in files.supportedContentTypes &&
     request.url.startsWith '/assets'
    # TODO: move this to cdn or nginx
    handle_static_file_request request, response
  else if type == 'text/html'
    router = new Router new Data, View
    router.navigate request.url, {'response': response }
  else if type == 'application/json'
    # TODO: move this to firebase
    handle_api_request request, response, type

server.listen process.env.WEB_PORT

handle_static_file_request = (request, response) ->
  relative_path = request.url.substring(1, request.url.length)
  files.getFile relative_path, (file) ->
    response.writeHead 200, 'Content-Type': file.contentType
    unless file.encoding == 'binary'
      response.end file.data
    else
      response.end file.data, 'binary'

handle_api_request = (request, response, type) ->
  data = new Data
  if request.url in ['/posts', '/posts/']
    Q.spawn ->
      posts = yield data.updatePosts()

      response.writeHead 200, 'Content-Type': type
      response.end JSON.stringify data.posts()
  else if match = /^\/posts\/([a-zA-Z0-9\-]+)$/.exec request.url
    Q.spawn ->
      slug = match[1]
      yield data.updatePost slug

      response.writeHead 200, 'Content-Type': type
      response.end JSON.stringify data.post slug
  else if match = /^\/posts\/([a-zA-Z0-9\-]+)\/comments$/.exec request.url
    Q.spawn ->
      slug = match[1]
      yield data.updatePost slug

      response.writeHead 200, 'Content-Type': type
      response.end JSON.stringify data.commentsForSlug slug
