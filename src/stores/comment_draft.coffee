{Store} = require './../../vendor/eightyeight/src/eightyeight.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'commentDraft'

  constructor: (dispatcher) ->
    super

    @_addListener constants.comment.draft.attributeChanged, @_handleAttributeChanged

    @_draftBody = ''
    @_draftValid = false
    @_draftErrors = {}

  data: ->
    draft:
      body: @_draftBody
    errors: @_draftErrors
    valid: @_draftValid

  _handleAttributeChanged: ({data: {attribute: attribute, value: value}}) =>
    @_draftBody = value

    @_change()
