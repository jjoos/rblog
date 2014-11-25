request = require 'superagent'
require('q-superagent') request
Q = require 'q'

constants = require './../constants.coffee'

module.exports = class
  actionName: 'commentDraft'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

  submitDraft: ->
    async = Q.async ->
      postCommentDraft = request
        .get "http://localhost:3901/posts/#{slug}"
        .set 'Accept', 'application/json'
        .q()

    data = @_dispatcher.store('commentDraft').data()

  updateDraftComment: (attribute, value) ->
    @_dispatcher.dispatch constants.comment.draft.attributeChanged,
      attribute: attribute
      value: value
