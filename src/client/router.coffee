require './router'
_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

class ClientRouter extends Backbone.Router
  constructor: ->
    _.extend @, Router

    @initializeRoutes()

    super

    Backbone.history.start pushState: true
    console.info 'started routing'

  initializeRoutes: ->
    for key, route of @routeRegexes
      @route route.regex, route.callback

module.exports = ClientRouter
