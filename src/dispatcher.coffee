EventEmitter = require 'wolfy87-eventemitter'

class Dispatcher extends EventEmitter
  @_storeClasses: []
  @_actionClasses: []

  @registerStoreClass: (storeClass) ->
    @_storeClasses.push storeClass

  @registerActionClass: (actionClass) ->
    @_actionClasses.push actionClass

  constructor: ->
    @_stores = {}
    @_actions = {}
    for storeClass in @constructor._storeClasses
      store = new storeClass @
      @_stores[store.storeName] = store

    for actionClass in @constructor._actionClasses
      action = new actionClass @
      @_actions[action.actionName] = action

  store: (name) ->
    @_stores[name]

  actions: (name) ->
    @_actions[name]

  dispatch: (eventName, data) ->
    @emitEvent eventName, [ data: data ]

Dispatcher.registerStoreClass require('./stores/comments.coffee')
Dispatcher.registerStoreClass require('./stores/posts.coffee')
Dispatcher.registerActionClass require('./actions/posts.coffee')

module.exports = Dispatcher