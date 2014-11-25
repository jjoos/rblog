{Store} = require './../../vendor/capacitor/src/capacitor.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'commentDraft'

  constructor: (dispatcher) ->
    super

    @_registerEventHandlers()

    @_draftBody = ''
    @_draftValid = false
    @_draftErrors = {}

  _registerEventHandlers: ->
    @_addListener constants.comment.draft.attributeChanged, @_handleAttributeChanged

  data: ->
    draft:
      body: @_draftBody
    errors: @_draftErrors
    valid: @_draftValid

  _handleAttributeChanged: ({data: {attribute: attribute, value: value}}) =>
    @_draftBody = value

    @_change()
