# @jsx React.DOM
{React} = require './../vendor/eightyeight/src/eightyeight.coffee'

BlogLayout = require './views/blog_layout.cjsx'
Index = require './views/index.cjsx'
Post = require './views/post.cjsx'

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
