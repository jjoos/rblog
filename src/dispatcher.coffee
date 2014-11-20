request = require 'superagent'
require('q-superagent') request
EventEmitter = require 'wolfy87-eventemitter'
Q = require 'q'

class Dispatcher extends EventEmitter
  @_storeClasses: []

  @registerStoreClass: (storeClass) ->
    @_storeClasses.push storeClass

  constructor: ->
    @_stores = {}
    for storeClass in @constructor._storeClasses
      store = new storeClass @
      @_stores[store.storeName] = store

  store: (name) ->
    @_stores[name]

  updatePosts: ->
    Q.spawn =>
      response = request
        .get 'http://localhost:3901/posts'
        .set 'Accept', 'application/json'
        .q()

      posts = (yield response).body
      
      @_emitEvent 'fetchedPosts', posts: posts

  updatePost: (slug) ->
    Q.spawn =>
      requestPost = request
        .get "http://localhost:3901/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

      requestComments = request
        .get "http://localhost:3901/posts/#{slug}/comments"
        .set 'Accept', 'application/json'
        .q()

      posts = (yield requestPost).body
      @_emitEvent 'fetchedPost',
        slug: slug
        post: posts

      comments = (yield requestComments).body
      @_emitEvent 'fetchedCommentsForPost',
        slug: slug
        comments: comments

  _emitEvent: (event, data) ->
    @emitEvent event, [ data: data ]

Dispatcher.registerStoreClass require('./stores/comments.coffee')
Dispatcher.registerStoreClass require('./stores/posts.coffee')

module.exports = Dispatcher