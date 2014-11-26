{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

module.exports = React.createClass
  displayName: 'Comment'

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
