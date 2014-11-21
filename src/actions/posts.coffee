constants = require './../constants.coffee'
request = require 'superagent'
require('q-superagent') request
Q = require 'q'

class Posts
  actionName: 'posts'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

  fetchPost: (slug) ->
    async = Q.async =>
      requestPost = request
        .get "http://localhost:3901/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

      requestComments = request
        .get "http://localhost:3901/posts/#{slug}/comments"
        .set 'Accept', 'application/json'
        .q()

      @_dispatcher.dispatch constants.post.fetched,
        slug: slug
        post: (yield requestPost).body

      @_dispatcher.dispatch constants.post.fetchedComments,
        slug: slug
        comments: (yield requestComments).body

    async()

  fetchPosts: ->
    async = Q.async =>
      response = request
        .get 'http://localhost:3901/posts'
        .set 'Accept', 'application/json'
        .q()

      @_dispatcher.dispatch constants.posts.fetched, posts: (yield response).body

    async()
module.exports = Posts