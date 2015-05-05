{Helper} = require 'onehundredfourtytwo'
React = require 'react'
commonmark = require 'commonmark'

BlogLayout = require './blog_layout'
Comments = require './comments'
NewComment = require './new_comment'

module.exports = React.createClass
  displayName: 'Post'

  mixins: [Helper]

  render: ->
    reader = new commonmark.DocParser()
    writer = new commonmark.HtmlRenderer()
    parsed = reader.parse @data('post').post.body
    result = writer.render(parsed)

    <BlogLayout>
      <article>
        <h2>{@data('post').post.title}</h2>
        <p dangerouslySetInnerHTML={__html: result} />
      </article>
      <Comments />
      <NewComment />
    </BlogLayout>
