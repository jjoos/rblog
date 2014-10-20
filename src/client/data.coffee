_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $
Q = require 'q'

Data = require '../data.coffee'

class ClientData extends Data
  _(@).extend Backbone.Events

  @updatePosts: =>
    $.ajax
      dataType: "json",
      url: '/posts',
      success: (data) =>
        @_posts = data
        @trigger 'change'

  @updatePost: (slug) ->
    Q.spawn ->
      @_posts ||= {}
      @_posts[slug] = yield $.ajax
        dataType: "json",
        url: "/posts/#{slug}",

      @_posts[slug]['comments'] = yield $.ajax
        dataType: "json",
        url: "/posts/#{slug}/comments",

      _(@_posts[slug]['comments']).each (comment) ->
        @_comments[comment.id] = comment

      @trigger 'change'

module.exports = ClientData