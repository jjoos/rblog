fs = require 'fs'

cache = {}

type_extension_map = [
    extension: '.css'
    type: 'text/css'
    encoding: 'utf8'
  ,
    extension: '.js'
    type: 'application/javascript'
    encoding: 'utf8'
  ,
    extension: '.html'
    type: 'text/html'
    encoding: 'utf8'
  ,
    extension: '.txt'
    type: 'text/plain'
    encoding: 'utf8'
  ,
    extension: '.jpg'
    type: 'image/jpeg'
    encoding: 'binary'
  ,
    extension: '.png'
    type: 'image/png'
    encoding: 'binary'
  ,
    extension: '.gif'
    type: 'image/gif'
    encoding: 'binary'
  ]

get_type_from_path = (path) ->
  for mapping in type_extension_map
    extension = path.slice(path.length - mapping.extension.length, path.length)
    if extension == mapping.extension
      return mapping

  console.error "Unknown file type for '#{path}'."
  return 'text/plain'

readFile = (path, callback) ->
  type = get_type_from_path path
  # TODO sanitize path so it cannot escape some public folder
  fs.readFile path, encoding: type.encoding, (error, data) ->
    return console.log error if error

    callback { data: data, contentType: type.type, encoding: type.encoding }

cacheFile = (path, file) ->
  cache[path] = file

watchFile = (path) ->
  fs.watch path, (event) ->
    readFile path, (data) -> cacheFile(path, data) if event == 'change'

getFile = (path, callback) ->
  if cache[path]?
    callback cache[path]
    return

  readFile path, (data) ->
    cacheFile path, data
    callback data
    watchFile path

module.exports.supportedContentTypes =
  type_extension_map.map (file) -> file.type
module.exports.getFile = getFile
