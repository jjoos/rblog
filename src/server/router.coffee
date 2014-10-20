Router = require '../router.coffee'

class ServerRouter extends Router
  navigate: (url, options) ->
    for key, value of @routeRegexes()
      match = value.regex.exec url

      if match
        [full_match, groups..., rest] = match
        @[value.callback](options)

module.exports = ServerRouter