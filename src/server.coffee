http = require 'http'
React = require 'react'
views = require './views'
files = require './server/files'
db = require './server/database.coffee'
_ = require 'underscore'
require './server/configuration.coffee'

static_file_prefx = '/assets'

server = http.createServer (request, response) ->
  if request.url.slice(0, static_file_prefx.length) == static_file_prefx
    relative_path = request.url.substring(1, request.url.length)
    files.getFile relative_path, (file) ->
      response.writeHead 200, 'Content-Type': file.contentType
      response.write file.data
      response.end()
  else
    posts = db.Post.findAll().success (posts) ->
      posts = _(posts).map (post) ->
        post.dataValues

    appHtml = React.renderComponentToString views.Index(posts: posts)
    files.getFile 'assets/index.html', (file) ->
      appHtml = file.data.replace '<body />', "<body>#{appHtml}</body>"

      response.writeHead 200, 'Content-Type': 'text/html'
      response.write appHtml
      response.end()

server.listen process.env.WEB_PORT
