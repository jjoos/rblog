http = require 'http'
React = require 'react'
views = require './views'
files = require './server/files'
db = require './server/database.coffee'
Negotiator = require 'negotiator'

_ = require 'underscore'
require './server/configuration.coffee'

static_file_prefx = '/assets'

availableMediaTypes =
  ['text/html', 'application/json'].concat files.supportedContentTypes

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes
  # 404 on favicon
  response.writeHead 404; response.end() if request.url == '/favicon.ico'

  if type == 'text/html'
    # Html documents
    files.getFile 'assets/template.html', (template) ->
      appHtml = ''
      if request.url == '/'
        db.Post.findAll().success (posts) ->
          posts = _(posts).map (post) ->
            post.dataValues

          appHtml = React.renderComponentToString views.Index(posts: posts)
          appHtml = template.data.replace '<body />', "<body>#{appHtml}</body>"
          response.writeHead 200, 'Content-Type': type
          response.end appHtml
      else
        match = /posts\/([A-Za-z0-9\-]+)/.exec request.url
        if match
          db.Post.find(where: {'slug': match[1]}).success (post) ->
            appHtml = React.renderComponentToString views.Post(post: post)
            appHtml = template.data.replace '<body />',"<body>#{appHtml}</body>"
            response.writeHead 200, 'Content-Type': type
            response.end appHtml

  if type == 'application/json'
    # Api, should be done by a proper api
    if request.url in ['/posts','/posts/']
      db.Post.findAll().success (posts) ->
        posts = _(posts).map (post) ->
          post.dataValues

        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify posts
  else if type in files.supportedContentTypes
    # Static file serving, should be done by nginx
    if request.url.slice(0, static_file_prefx.length) == static_file_prefx
      relative_path = request.url.substring(1, request.url.length)
      files.getFile relative_path, (file) ->
        response.writeHead 200, 'Content-Type': file.contentType
        unless file.encoding == 'binary'
          response.end file.data
        else
          response.end file.data, 'binary'
  else
    # Content type not supported
    response.writeHead 415
    response.end()

server.listen process.env.WEB_PORT
