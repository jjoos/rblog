# @jsx React.DOM
React = require 'react'

BlogLayout = require './views/blog_layout.cjsx'
Index = require './views/index.cjsx'
Post = require './views/post.cjsx'
Comments = require './views/comments.cjsx'

class View
  @renderIndex: (dispatcher, options) ->
    posts = dispatcher.store('posts').posts().data
    component = <BlogLayout>
        <Index posts={posts} />
      </BlogLayout>

    @renderView(component, options)

  @renderPost: (dispatcher, slug, options) ->
    post = dispatcher.store('posts').post(slug).data

    component = <BlogLayout>
        <Post post={post} />
        <Comments comments={post.comments} />
      </BlogLayout>

    @renderView(component, options)

  @renderArchive: (dispatcher, options) ->
    component = <BlogLayout>
        Archive
      </BlogLayout>

    @renderView(component, options)

  @renderAbout: (dispatcher, options) ->
    component = <BlogLayout>
        About
      </BlogLayout>

    @renderView(component, options)

  @renderView: (component, options) ->
    React.renderComponent component, window.document.body

module.exports = View
