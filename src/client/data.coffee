_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
Q = require 'q'

Data = require '../data.coffee'

class ClientData extends Data
  constructor: ->
    _(@).extend Backbone.Events

  updatePosts: ->
    async = Q.async =>
      @_posts = yield $.ajax
        dataType: "json",
        url: '/posts'
      
      @trigger 'change'

    async()

  updatePost: (slug) ->
    async = Q.async =>
      @_posts ||= {}
      post = $.ajax
        dataType: "json",
        url: "/posts/#{slug}"

      @_posts[post.id] = post

      @_posts[post.id]['comments'] = yield $.ajax
        dataType: "json",
        url: "/posts/#{slug}/comments"

      for comment in @_posts[post.id]['comments']
        @_comments[comment.id] = comment

      @trigger 'change'

    async()

module.exports = ClientData