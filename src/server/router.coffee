Router = require '../router.coffee'
Q = require 'q'

class ServerRouter extends Router
  navigate: (url, options) ->
    for route, regex of @routeRegexes()
      match = regex.exec url

      if match
        args = match[1..-1]
        @[route](args..., options)

  wrapper: (update, render) ->
    Q.spawn ->
      yield update() if update?
      render()

module.exports = ServerRouter