# @jsx React.DOM
React = require 'react'

Summary = require './summary.cjsx'

module.exports = React.createClass
  displayName: 'Index'

  posts: ->
    for post in @props.posts
      <Summary
        post={post}
        key={post.slug} />

  render: ->
    <div>
      {@posts()}
    </div>
