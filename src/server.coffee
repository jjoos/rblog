http = require 'http'
pg = require 'pg'
React = require 'react'
views = require './views'
files = require './server/files'

conString = "postgres://localhost:3100/hackerone_development"
pg.connect conString, (err, client, done) ->
  return console.error("error fetching client from pool", err) if err

  # client.query "SELECT * FROM users", (err, result) ->  
  #   done()
  #   return console.error("error running query", err) if err

  #   console.log result.rows

server = http.createServer (request, response) ->
  if request.url == '/style.css'
    files.getFile 'assets/style.css', (data) ->
      response.writeHead 200, 'Content-Type': 'text/css'
      response.write data
      response.end()
  else if request.url == '/bundle.js'
    files.getFile 'assets/bundle.js', (data) ->
      response.writeHead 200, 'Content-Type': 'text/javascript'
      response.write data
      response.end()
  else
    posts = [
        link: '/test-blog-post'
        title: 'Test title'
        body: 'Body of blog post'
      ]
    appHtml = React.renderComponentToString views.Index(posts: posts)
    files.getFile 'assets/index.html', (data) ->
      appHtml = data.replace '<body />', "<body>#{appHtml}</body>"

      response.writeHead 200, 'Content-Type': 'text/html'
      response.write appHtml
      response.end()

server.listen 8888