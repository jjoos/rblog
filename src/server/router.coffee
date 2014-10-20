Router = require '../router.coffee'

class ServerRouter extends Router
  navigate: (url, options) ->
    for key, value of @routeRegexes()
      match = value.regex.exec url

      if match
        args = match[1..-1]
        @[value.callback](args..., options)

module.exports = ServerRouter