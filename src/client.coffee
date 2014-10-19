# @jsx React.DOM

$ = require 'jquery'
React = require 'react'
_ = require 'underscore'
Backbone = require 'backbone'
Backbone.$ = $
views = require './views'

class AppRouter extends Backbone.Router
  routes:
    '': 'showIndex'
    'test2.html': 'showIndex'
    'about': 'showAbout'
    'archives': 'showArchives'
    'posts/:slug': 'showPost'

  initialize: ->
    @data = new Data
    @container = window.document.body

  execute: (callback, args) ->
    # stop listening on the old route for changes in the data
    @data.off 'change'
    callback.apply @, args if callback?

  showIndex: ->
    @data.updatePosts()
    if @data.posts()?
      @renderIndex()

    @data.on 'change', =>
      @renderIndex()

  renderIndex: (data) ->
    @component = <views.Index posts={data.posts()} />

    @renderView()

  showArchives: ->
    @component = <BlogLayout>
        Archive
      </BlogLayout>

    @renderView()

  showPost: (slug) ->
    @data.updatePost()
    if @data.posts()?
      @renderPost(slug)

    @data.on 'change', =>
      @renderPost(slug)

  renderPost: (slug) ->
    post = _(@data.posts()).find (post) -> post.slug == slug
    @component = <views.Post post={post} />

    @renderView()

  showAbout: ->
    @component = <BlogLayout>
        About me
      </BlogLayout>

    @renderView()

  renderView: ->
    React.renderComponent @component, @container

class Data
  constructor: ->
    _.extend @, Backbone.Events

  updatePosts: =>
    $.ajax
      dataType: "json",
      url: '/posts',
      success: (data) =>
        @_posts = data
        @trigger 'change'

  updatePost: (slug) =>
    $.ajax
      dataType: "json",
      url: "/posts/#{slug}",
      success: (data) =>
        @_post = data
        @trigger 'change'

  post: ->
    @_post

  posts: ->
    @_posts

$(document).ready ->
  router = new AppRouter

  Backbone.history.start pushState: true

  $(document).on "click", "a:not([data-bypass])", (event) ->
    href = $(this).attr 'href'
    root = "#{location.protocol}//#{location.host}/"
    if (href.prop && href.prop.slice(0, root.length) == root) ||
       (href[0] == '/' && href[1] != '/')

      router.navigate href, true
      event.preventDefault()
