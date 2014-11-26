# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

BlogLayout = require './blog_layout.cjsx'
Comments = require './comments.cjsx'
NewComment = require './new_comment.cjsx'

module.exports = React.createClass
  displayName: 'Post'

  render: ->
    <article>
      <h2>{@props.post.title}</h2>
      <p>{@props.post.body}</p>
    </article>
