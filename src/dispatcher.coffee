Q = require 'q'

class Dispatcher
  @_storeClasses: []
  @_actionClasses: []

  @registerStoreClass: (storeClass) ->
    @_storeClasses.push storeClass

  @registerActionClass: (actionClass) ->
    @_actionClasses.push actionClass

  constructor: ->
    @_callbacks = {}
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

  addListener: (eventName, callback, store) ->
    @_callbacks[eventName] ||= {}
    @_callbacks[eventName][store.storeName] = callback

  removeListener: (eventName, callback, store) ->
    @_callbacks[eventName] ||= {}
    delete @_callbacks[eventName][store.storeName]

  removeAllListeners: (eventName) ->
    @_callbacks[eventName] = {}

  dispatch: (eventName, data) ->
    promise = @currentDispatchPromise
    if !promise || promise.isFulfilled()
      @currentDispatchPromise = @_emitEvent eventName, data: data
    else
      @currentDispatchPromise.then =>
        @_emitEvent eventName, data: data

    @currentDispatchPromise

  _emitEvent: (eventName, payLoad) ->
    promiseMethods = {}
    promises = {}
    for storeName, callback of @_callbacks[eventName]
      do (callback, storeName) ->
        promiseMethods[storeName] =
          Q.fbind -> callback payLoad, promises

    for storeName, promiseMethod of promiseMethods
      promises[storeName] = promiseMethod().done()

    Q.all(promises)

Dispatcher.registerStoreClass require('./stores/comments.coffee')
Dispatcher.registerStoreClass require('./stores/posts.coffee')
Dispatcher.registerActionClass require('./actions/posts.coffee')

module.exports = Dispatcher
