# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

module.exports = React.createClass
  displayName: 'NewComment'

  mixins: [
    DispatcherHelper
  ]

  handleSubmit: (event) ->
    event.preventDefault()
    @actions('commentDraft').submitDraft()

  handleCommentChange: (event) ->
    @actions('commentDraft').updateDraftComment 'body', event.target.value

  render: ->
    draft = @data('commentDraft')
    <form onSubmit={@handleSubmit}>
      <div>{draft.errors.base}</div>
      Write comment:<br />
      <div>{draft.errors.body}</div>
      <input
          type='text'
          value={draft.draft.body}
          onChange={@handleCommentChange} />
      <input
          disabled={draft.valid}
          type='submit' />
    </form>
