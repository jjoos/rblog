constants = require './../constants.coffee'

module.exports = class CommentDraft
  storeName: 'commentDraft'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()

    @_draftBody = ''
    @_draftValid = false
    @_draftErrors = {}

  data: ->
    draft:
      body: @_draftBody
    errors: @_draftErrors
    valid: @_draftValid

  _registerEventHandlers: ->
    @_addListener constants.comment.draft.attributeChanged, @_handleAttributeChanged

  _addListener: (eventName, callback) =>
    @_dispatcher.addListener eventName, callback, @storeName

  _handleAttributeChanged: ({data: {attribute: attribute, value: value}}) =>
    @_draftBody = value

    @_change()

  _change: ->
    @_dispatcher.dispatch 'change'
