# @jsx React.DOM
React = require 'react'

BlogLayout = require './views/blog_layout.cjsx'
Index = require './views/index.cjsx'
Post = require './views/post.cjsx'
Comments = require './views/comments.cjsx'
NewComment = require './views/new_comment.cjsx'

module.exports =
  renderIndex: (dispatcher) ->
    posts = dispatcher.store('posts').data()

    <BlogLayout>
      <Index posts={posts.data} />
    </BlogLayout>

  renderPost: (dispatcher) ->
    navigation = dispatcher.store('navigation').data()
    post = dispatcher.store('post').data()

    <BlogLayout>
      <Post post={post.data} />
      <Comments comments={post.data.comments} />
      <NewComment dispatcher={dispatcher} />
    </BlogLayout>

  renderArchive: (dispatcher) ->
    <BlogLayout>
      Archive
    </BlogLayout>

  renderAbout: (dispatcher) ->
    <BlogLayout>
      About
    </BlogLayout>
