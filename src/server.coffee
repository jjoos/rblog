http = require 'http'
pg = require 'pg'
# @jsx React.DOM

React = require 'react'
views = require './views'
fs = require 'fs'

template = ''
stylesheet = ''
javascript = ''

fs.readFile 'assets/index.html', 'utf8', (err, data) ->
  return console.log err if err

  template = data

fs.readFile 'assets/style.css', 'utf8', (err, data) ->
  return console.log err if err

  stylesheet = data

fs.readFile 'assets/bundle.js', 'utf8', (err, data) ->
  return console.log err if err

  javascript = data

conString = "postgres://localhost:3100/hackerone_development"
pg.connect conString, (err, client, done) ->
  return console.error("error fetching client from pool", err) if err

  # client.query "SELECT * FROM users", (err, result) ->  
  #   done()
  #   return console.error("error running query", err) if err

  #   console.log result.rows

server = http.createServer (request, response) ->
  if request.url == '/style.css'
    response.writeHead 200, 'Content-Type': 'text/css'
    response.write stylesheet
    response.end()
  else if request.url == '/bundle.js'
    response.writeHead 200, 'Content-Type': 'text/javascript'
    response.write javascript
    response.end()
  else
    posts = [
        link: '/test-blog-post'
        title: 'Test title'
        body: 'Body of blog post'
      ]
    appHtml = React.renderComponentToString views.Index(posts: posts)
    appHtml = template.replace '<body />', "<body>#{appHtml}</body>"

    response.writeHead 200, 'Content-Type': 'text/html'
    response.write appHtml
    response.end()

server.listen 8888