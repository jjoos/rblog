{Helper} = require 'onehundredfourtytwo'
React = require 'react'

BlogLayout = require './blog_layout.cjsx'
Summary = require './summary.cjsx'

module.exports = React.createClass
  displayName: 'Index'

  mixins: [Helper]

  posts: ->
    return null if @data('posts').state == 'loading'
    for post in @data('posts').posts
      <Summary
        post={post}
        key={post.slug} />

  render: ->
    <BlogLayout>
      {@posts()}
    </BlogLayout>
