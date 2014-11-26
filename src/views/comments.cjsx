# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

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
