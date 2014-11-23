Router = require '../router.coffee'
Q = require 'q'

class ServerRouter extends Router
  navigate: (url, options) ->
    for route, regex of @routeRegexes()
      match = regex.exec url

      if match
        args = match[1..-1]
        @[route](args..., options)

  wrapper: (action, render) ->
    if action?
      Q.spawn ->
        yield action()

        render()
    else
      render()

module.exports = ServerRouter
