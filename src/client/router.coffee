_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

Router = require '../router.coffee'
VirtualClass = require '../util/virtual-class.coffee'

class ClientRouter extends VirtualClass Backbone.Router, Router
  constructor: (data, view) ->
    @initializeRoutes()

    super

  execute: (callback, args) ->
    # stop listening on the old route for changes in the data
    @data.removeEvent 'change'
    callback.apply @, args if callback?

  initializeRoutes: ->
    for key, regex of @routeRegexes()
      @route regex, key

module.exports = ClientRouter
