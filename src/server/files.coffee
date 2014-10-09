fs = require 'fs'

cache = {}

readFile = (path, callback) ->
  # TODO sanitize path so it cannot escape some public folder
  fs.readFile path, 'utf8', (error, data) ->
    return console.log error if error

    callback data

cacheFile = (path, data) ->
  cache[path] = data

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

module.exports.getFile = getFile
