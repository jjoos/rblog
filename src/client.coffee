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
    ':slug': 'showPost'

  initialize: ->
    @container = window.document.body

  showIndex: ->
    @component = <views.Index posts={@data().posts} />

    @renderView()

  showArchives: ->
    @component = <BlogLayout>
        Archive
      </BlogLayout>

    @renderView()

  showPost: (slug) ->
    post = _(@data().posts).find (post) -> post.link == "/#{slug}"

    @component = <views.Post post={post} />

    @renderView()

  showAbout: ->
    @component = <BlogLayout>
        About me
      </BlogLayout>

    @renderView()

  renderView: ->
    React.renderComponent @component, @container

  data: -> posts: [{
    link: '/test-blog-post'
    title: 'Test title'
    body: 'Body of blog post'
  }]

$(document).ready ->
  router = new AppRouter

  Backbone.history.start pushState: true

  $(document).on "click", "a:not([data-bypass])", (event) ->
    href = $(this).attr("href")
    protocol = @protocol + "//"
    if href.slice(protocol.length) isnt protocol
      event.preventDefault()
      router.navigate href, true
