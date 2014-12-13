React = require 'react'

BlogLayout = require './views/blog_layout'
Index = require './views/index'
Post = require './views/post'

module.exports =
  renderIndex: (dispatcher) ->
    <Index dispatcher={dispatcher} />

  renderPost: (dispatcher) ->
    <Post dispatcher={dispatcher} />

  renderArchive: (dispatcher) ->
    <BlogLayout dispatcher={dispatcher}>
      Archive
    </BlogLayout>

  renderAbout: (dispatcher) ->
    <BlogLayout dispatcher={dispatcher}>
      About
    </BlogLayout>
