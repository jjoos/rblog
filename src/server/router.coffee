Router = require '../router.coffee'

class ServerRouter extends Router
  navigate: (url, options) ->
    for route, regex of @routeRegexes()
      match = regex.exec url

      if match
        args = match[1..-1]
        @[route](args..., options)

module.exports = ServerRouter
