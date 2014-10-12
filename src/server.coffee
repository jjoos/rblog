http = require 'http'
React = require 'react'
views = require './views'
files = require './server/files'

static_file_prefx = '/assets'

server = http.createServer (request, response) ->
  if request.url.slice(0, static_file_prefx.length) == static_file_prefx
    relative_path = request.url.substring(1, request.url.length)
    files.getFile relative_path, (file) ->
      response.writeHead 200, 'Content-Type': file.contentType
      response.write file.data
      response.end()
  else
    posts = [
        link: '/test-blog-post'
        title: 'Test title'
        body: 'Body of blog post'
      ]
    appHtml = React.renderComponentToString views.Index(posts: posts)
    files.getFile 'assets/index.html', (file) ->
      appHtml = file.data.replace '<body />', "<body>#{appHtml}</body>"

      response.writeHead 200, 'Content-Type': 'text/html'
      response.write appHtml
      response.end()

server.listen 8888
