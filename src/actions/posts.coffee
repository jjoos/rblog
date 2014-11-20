request = require 'superagent'
require('q-superagent') request
Q = require 'q'

class Posts
  actionName: 'posts'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

  fetchPost: (slug) ->
    Q.spawn =>
      requestPost = request
        .get "http://localhost:3901/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

      requestComments = request
        .get "http://localhost:3901/posts/#{slug}/comments"
        .set 'Accept', 'application/json'
        .q()

      @_dispatcher.dispatch 'fetchedPost',
        slug: slug
        post: (yield requestPost).body

      @_dispatcher.dispatch 'fetchedCommentsForPost',
        slug: slug
        comments: (yield requestComments).body

  fetchPosts: ->
    Q.spawn =>
      response = request
        .get 'http://localhost:3901/posts'
        .set 'Accept', 'application/json'
        .q()

      @_dispatcher.dispatch 'fetchedPosts', posts: (yield response).body

module.exports = Posts