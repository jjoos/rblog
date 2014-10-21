_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$ = $

Data = require '../data.coffee'

class ClientData extends Data
  constructor: ->
    _(@).extend Backbone.Events

  updatePosts: =>
    $.ajax
      dataType: "json",
      url: '/posts',
      success: (data) =>
        @_posts = data
        @trigger 'change'

  updatePost: (slug) =>
    @_posts ||= {}
    $.ajax
      dataType: "json",
      url: "/posts/#{slug}",
      success: (data) =>
        @_posts[slug] = data
        @trigger 'change'

module.exports = ClientData