_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

class Data
  _(@).extend Backbone.Events

  @updatePosts: =>
    $.ajax
      dataType: "json",
      url: '/posts',
      success: (data) =>
        @_posts = data
        @trigger 'change'

  @updatePost: (slug) =>
    $.ajax
      dataType: "json",
      url: "/posts/#{slug}",
      success: (data) =>
        @_post = data
        @trigger 'change'

  @post: (slug) ->
    _(@_posts).find (post) -> post.slug == slug

  @posts: ->
    @_posts

module.exports = Data