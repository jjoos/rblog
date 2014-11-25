module.exports = class
  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

  _addListener: (eventName, callback) =>
    @_dispatcher.addListener eventName, callback, @storeName

  _change: ->
    @_dispatcher.dispatch 'change'
