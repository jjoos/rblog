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

static_file_prefx = '/assets'

availableMediaTypes =
  ['text/html', 'application/json'].concat files.supportedContentTypes

server = http.createServer (request, response) ->
  data = new Data
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes
  # 404 on favicon
  response.writeHead 404; response.end() if request.url == '/favicon.ico'

  if type in files.supportedContentTypes &&
     request.url.slice(0, static_file_prefx.length) == static_file_prefx
    # Static file serving, should be done by nginx
    relative_path = request.url.substring(1, request.url.length)
    files.getFile relative_path, (file) ->
      response.writeHead 200, 'Content-Type': file.contentType
      unless file.encoding == 'binary'
        response.end file.data
      else
        response.end file.data, 'binary'
  else if type == 'text/html'
    # Html documents
    router = new Router data, View
    router.navigate request.url, {'response': response }
  else if type == 'application/json'
    # Api, should be done by a proper api
    if request.url in ['/posts', '/posts/']
      Q.spawn ->
        posts = yield Data.updatePosts()

        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify Data.posts
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)$/.exec request.url
      Q.spawn ->
        slug = match[1]
        yield Data.updatePost slug

        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify Data.post slug
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)\/comments$/.exec request.url
      Q.spawn ->
        slug = match[1]
        yield Data.updatePost slug

        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify Data.commentsForSlug slug
  else
    # Content type not supported
    response.writeHead 415
    response.end()

server.listen process.env.WEB_PORT
