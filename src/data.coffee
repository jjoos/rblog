_ = require 'underscore'
request = require 'superagent'
require('q-superagent') request
EventEmitter = require 'wolfy87-eventemitter'
Q = require 'q'

class Data extends EventEmitter
  updatePosts: ->
    Q.spawn =>
      response = yield request
        .get 'http://localhost:3901/posts'
        .set 'Accept', 'application/json'
        .q()

      @_posts = response.body

      @emitEvent 'change'

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

      @_posts ||= {}
      @_posts[slug] = (yield requestPost).body

      @_posts[slug]['comments'] = (yield requestComments).body
      for comment in @_posts[slug]['comments']
        @_comments ||= {}
        @_comments[comment.id] = comment
      @emitEvent 'change'

  post: (slug) ->
    for _, post of @_posts
      return post if post.slug == slug

  posts: ->
    post for _, post of @_posts

  commentsForSlug: (slug) ->
    @_posts[slug]['comments']

module.exports = Data