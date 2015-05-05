{Helper} = require 'onehundredfourtytwo'
React = require 'react'

module.exports = class Comment extends React.Component
  render: ->
    <div>
      <div>
        <span>Author: {@props.comment.author}</span>
        <span>Created at: {@props.comment.createdAt}</span>
      </div>
      <div>
        {@props.comment.body}
      </div>
    </div>
