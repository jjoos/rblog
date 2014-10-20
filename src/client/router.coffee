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

  execute: (callback, args) ->
    # stop listening on the old route for changes in the data
    @data.off 'change'
    callback.apply @, args if callback?

  initializeRoutes: ->
    for key, regex of @routeRegexes()
      @route regex, key

  wrapper: (update, render) ->
    if update?
      update()

      @data.on 'change', ->
        render()
    else
      render()

module.exports = ClientRouter
