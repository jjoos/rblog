http = require 'http'
Negotiator = require 'negotiator'

Data = require './data'
db = require './database'
Q = require 'q'

require '../util/configuration'

availableMediaTypes = ['application/json']

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  web_server_address = "http://localhost:#{process.env.WEB_PORT}"

  if type == 'application/json'
    data = new Data
    if request.url in ['/posts', '/posts/']
      Q.spawn ->
        posts = yield data.updatePosts()
        response.setHeader "Access-Control-Allow-Origin", web_server_address
        response.setHeader "Access-Control-Allow-Methods", 'POST, GET, OPTIONS'
        response.setHeader "Access-Control-Max-Age", '1728000'
        response.setHeader "Access-Control-Allow-Headers", '*'
        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify data.posts()
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)$/.exec request.url
      Q.spawn ->
        slug = match[1]
        yield data.updatePost slug
        response.setHeader "Access-Control-Allow-Origin", web_server_address
        response.setHeader "Access-Control-Allow-Methods", 'POST, GET, OPTIONS'
        response.setHeader "Access-Control-Max-Age", '1728000'
        response.setHeader "Access-Control-Allow-Headers", '*'
        response.writeHead 200, 'Content-Type': type
        response.end JSON.stringify data.post slug
    else if match = /^\/posts\/([a-zA-Z0-9\-]+)\/comments$/.exec request.url
      if request.method == 'GET'
        Q.spawn ->
          slug = match[1]
          yield data.updatePost slug
          response.setHeader "Access-Control-Allow-Origin", web_server_address
          response.setHeader "Access-Control-Allow-Methods", 'POST, GET, OPTIONS'
          response.setHeader "Access-Control-Max-Age", '1728000'
          response.setHeader "Access-Control-Allow-Headers", '*'
          response.writeHead 200, 'Content-Type': type
          response.end JSON.stringify data.commentsForSlug slug
      else if request.method == 'OPTIONS'
        request_header_keys = (key for key, _value of request.headers)
        request_header_keys.push('content-type')
        response.setHeader "Access-Control-Allow-Origin", web_server_address
        response.setHeader "Access-Control-Allow-Methods", 'POST, GET, OPTIONS'
        response.setHeader "Access-Control-Max-Age", '1728000'
        response.setHeader "Access-Control-Allow-Headers", request_header_keys.join ', '
        response.writeHead 204, 'Content-Type': type
        response.end ''
      else if request.method == 'POST'
        fullBody = ''

        request.on 'data', (chunk) ->
          fullBody += chunk.toString()
        
        request.on 'end', ->
          console.info fullBody
          yield data.saveComment request
          response.setHeader "Access-Control-Allow-Origin", web_server_address
          response.setHeader "Access-Control-Allow-Methods", 'POST, GET, OPTIONS'
          response.setHeader "Access-Control-Max-Age", '1728000'
          response.setHeader "Access-Control-Allow-Headers", '*'
          response.writeHead 201, 'Content-Type': type
          response.end fullBody

server.listen process.env.API_PORT
