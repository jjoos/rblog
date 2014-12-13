http = require 'http'
Negotiator = require 'negotiator'

files = require '../util/files'
require '../util/configuration'

availableMediaTypes = files.supportedContentTypes

server = http.createServer (request, response) ->
  negotiator = new Negotiator request
  type = negotiator.mediaType availableMediaTypes

  if type in files.supportedContentTypes
    # TODO: move this to cdn or nginx
    handle_static_file_request request, response

server.listen process.env.ASSETS_PORT

handle_static_file_request = (request, response) ->
  relative_path = request.url.substring(1, request.url.length)
  files.getFile relative_path, (file) ->
    response.writeHead 200, 'Content-Type': file.contentType
    unless file.encoding == 'binary'
      response.end file.data
    else
      response.end file.data, 'binary'
