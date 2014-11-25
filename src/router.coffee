constants = require './constants.coffee'

module.exports = class
  routeRegexes: ->
    index: /^\/?$/
    about: /^\/?about$/
    archive: /^\/?archives$/
    post: /^\/?posts\/([A-Za-z0-9\-]+)$/

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

  index: (options) ->
    @_dispatcher.actions('navigation').index options

  post: (slug, options) ->
    @_dispatcher.actions('navigation').post slug, options

  about: (options) ->
    @_dispatcher.actions('navigation').about options

  archive: (options) ->
    @_dispatcher.actions('navigation').archive options
