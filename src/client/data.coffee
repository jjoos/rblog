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
    Q.spawn =>
      @_posts = yield Q $.ajax
        dataType: "json",
        url: '/posts'

      @trigger 'change'

  updatePost: (slug) ->
    Q.spawn =>
      getPost = Q $.ajax
        dataType: "json",
        url: "/posts/#{slug}"

      getComments = Q $.ajax
        dataType: "json",
        url: "/posts/#{slug}/comments"

      @_posts ||= {}
      @_posts[slug] = yield getPost

      @_posts[slug]['comments'] = yield getComments
      for comment in @_posts[slug]['comments']
        @_comments ||= {}
        @_comments[comment.id] = comment
      @trigger 'change'

module.exports = ClientData
