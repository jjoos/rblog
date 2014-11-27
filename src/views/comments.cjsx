{Helper} = require 'onehundredfourtytwo'
React = require 'react'

Comment = require './comment.cjsx'

module.exports = React.createClass
  displayName: 'Comments'

  mixins: [Helper]

  comments: ->
    return null if @data('post').loading
    for comment in @data('post').comments
      <Comment
          comment={comment}
          key={comment.id} />

  render: ->
    <div>
      {@comments()}
    </div>
