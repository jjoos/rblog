# @jsx React.DOM
React = require 'react'

Comment = require './comment.cjsx'

module.exports = React.createClass
  displayName: 'Comments'

  comments: ->
    for comment in @props.comments
      <Comment
        comment={comment}
        key={comment.id} />

  render: ->
    <div>
      {@comments()}
    </div>
