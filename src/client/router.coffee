_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

Router = require '../router.coffee'
VirtualClass = require '../util/virtual-class.coffee'

module.exports = class extends VirtualClass Backbone.Router, Router
  constructor: (dispatcher, view) ->
    @initializeRoutes()

    super

  execute: (callback, args) ->
    # stop listening on the old route for changes in the data
    @_dispatcher.removeAllListeners 'change'
    callback.apply @, args if callback?

  initializeRoutes: ->
    for key, regex of @routeRegexes()
      @route regex, key
