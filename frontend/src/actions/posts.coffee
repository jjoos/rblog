{Actions} = require 'onehundredfourtytwo'
Q = require 'q'
request = require 'superagent'
require('q-superagent') request

constants = require './../constants'

module.exports = class extends Actions
  actionName: 'posts'

  fetchPost: ->
    async = Q.async =>
      {slug} = @_dispatcher.store('navigation').data()

      requestPost = request
        .get "https://api.lvh.me:8443/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

      requestComments = request
        .get "https://api.lvh.me:8443/posts/#{slug}/comments"
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
        .get 'https://api.lvh.me:8443/posts'
        .set 'Accept', 'application/json'
        .q()

      @_dispatcher.dispatch constants.posts.fetched, posts: (yield response).body

    async()
