constants = require './../constants.coffee'

module.exports = class
  storeName: 'navigation'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()

  data: ->
    @_options

  _registerEventHandlers: ->
    for _key, value of constants.navigation
      @_addListener value, (options) =>
        @_handleNavigation(options)

  _addListener: (eventName, callback) =>
    @_dispatcher.addListener eventName, callback, @storeName

  _handleNavigation: (options) =>
    @_options = options.data

  _change: ->
    @_dispatcher.dispatch 'change'
