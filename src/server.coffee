http = require 'http'
React = require 'react'
views = require './views'
files = require './server/files'
db = require './server/database.coffee'
Negotiator = require 'negotiator'

_ = require 'underscore'
require './server/configuration.coffee'

static_file_prefx = '/assets'

availableMediaTypes = ['text/html', 'application/json']

server = http.createServer (request, response) ->
  if request.url.slice(0, static_file_prefx.length) == static_file_prefx
    relative_path = request.url.substring(1, request.url.length)
    files.getFile relative_path, (file) ->
      response.writeHead 200, 'Content-Type': file.contentType
      response.write file.data
      response.end()
  else if request.url in ['','/','/posts','/posts/']
    posts = db.Post.findAll().success (posts) ->
      posts = _(posts).map (post) ->
        post.dataValues

      negotiator = new Negotiator request
      type = negotiator.mediaType availableMediaTypes
      if type == 'text/html'
        appHtml = React.renderComponentToString views.Index(posts: posts)
        files.getFile 'assets/index.html', (file) ->
          appHtml = file.data.replace '<body />', "<body>#{appHtml}</body>"

          response.writeHead 200, 'Content-Type': type
          response.write appHtml
          response.end()
          console.info 'rendered index.html'
      else if type == 'application/json' && request.url in ['/posts','/posts/']
        response.writeHead 200, 'Content-Type': type
        response.write JSON.stringify posts
        response.end()
      else
        response.writeHead 415, 'Content-Type': type
        response.end()

server.listen process.env.WEB_PORT
