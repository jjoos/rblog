{Actions} = require 'onehundredfourtytwo'
Q = require 'q'
request = require 'superagent'
require('q-superagent') request

constants = require './../constants.coffee'

module.exports = class extends Actions
  actionName: 'commentDraft'

  submitDraft: ->
    async = Q.async =>
      {draft} = @_dispatcher.store('commentDraft').data()
      {slug} = @_dispatcher.store('navigation').data()

      postCommentDraft = request
        .post "http://localhost:3901/posts/#{slug}/comments"
        .send draft
        .set 'Accept', 'application/json'
        .q()

      # dispatch event to put comment_draft store in waiting state
      # and do not wait on ajax request to finish
      console.info yield postCommentDraft

    async()

  updateDraftComment: (attribute, value) ->
    @_dispatcher.dispatch constants.comment.draft.attributeChanged,
      attribute: attribute
      value: value
