{Helper} = require 'onehundredfourtytwo'
React = require 'react'

BlogLayout = require './blog_layout'
Comments = require './comments'
NewComment = require './new_comment'

module.exports = React.createClass
  displayName: 'Post'

  mixins: [Helper]

  render: ->
    <BlogLayout>
      <article>
        <h2>{@data('post').post.title}</h2>
        <p>{@data('post').post.body}</p>
      </article>
      <Comments />
      <NewComment />
    </BlogLayout>
