{Actions} = require './../../vendor/capacitor/src/capacitor.coffee'
request = require 'superagent'
require('q-superagent') request
Q = require 'q'

constants = require './../constants.coffee'

module.exports = class extends Actions
  actionName: 'posts'

  fetchPost: ->
    async = Q.async =>
      {slug} = @_dispatcher.store('navigation').data()

      requestPost = request
        .get "http://localhost:3901/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

      requestComments = request
        .get "http://localhost:3901/posts/#{slug}/comments"
        .set 'Accept', 'application/json'
        .q()

      yield @_dispatcher.dispatch constants.post.fetched,
        slug: slug
        post: (yield requestPost).body

      yield @_dispatcher.dispatch constants.post.fetchedComments,
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
