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

  addListener: (eventName, callback, name) ->
    @_callbacks[eventName] ||= {}
    @_callbacks[eventName][name] = callback

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
    for name, callback of @_callbacks[eventName]
      do (callback, name) ->
        promiseMethods[name] =
          Q.fbind -> callback payLoad, promises

    for name, promiseMethod of promiseMethods
      promises[name] = promiseMethod().done()

    Q.all(promises)

Dispatcher.registerStoreClass require('./stores/comment_draft.coffee')
Dispatcher.registerStoreClass require('./stores/posts.coffee')
Dispatcher.registerStoreClass require('./stores/post.coffee')
Dispatcher.registerStoreClass require('./stores/navigation.coffee')
Dispatcher.registerActionClass require('./actions/posts.coffee')
Dispatcher.registerActionClass require('./actions/comment_draft.coffee')

module.exports = Dispatcher
