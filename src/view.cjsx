# @jsx React.DOM
React = require 'react'

BlogLayout = require './views/blog_layout.cjsx'
Index = require './views/index.cjsx'
Post = require './views/post.cjsx'
Comments = require './views/comments.cjsx'

module.exports = class View
  @renderIndex: (dispatcher) ->
    posts = dispatcher.store('posts').posts().data
    <BlogLayout>
      <Index posts={posts} />
    </BlogLayout>

  # TODO: get slug from navigation store
  @renderPost: (dispatcher, slug) ->
    post = dispatcher.store('posts').post(slug).data

    <BlogLayout>
      <Post post={post} />
      <Comments comments={post.comments} />
    </BlogLayout>

  @renderArchive: (dispatcher) ->
    <BlogLayout>
      Archive
    </BlogLayout>

  @renderAbout: (dispatcher) ->
    <BlogLayout>
      About
    </BlogLayout>
