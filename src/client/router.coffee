_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

Router = require '../router'
VirtualClass = require '../util/virtual-class'

class ClientRouter extends VirtualClass Backbone.Router, Router
  constructor: (data, view) ->
    @initializeRoutes()

    super

    Backbone.history.start pushState: true

  execute: (callback, args) ->
    # stop listening on the old route for changes in the data
    @data.off 'change'
    console.info arguments
    callback.apply @, args if callback?

  initializeRoutes: ->
    console.info 'initializing routes'
    for key, route of @routeRegexes()
      console.info route.regex, route.callback
      @route route.regex, route.callback

module.exports = ClientRouter
