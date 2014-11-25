Q = require 'q'

constants = require './../constants.coffee'

class Comments
  storeName: 'comments'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()

  _registerEventHandlers: ->
    @_addListener constants.post.fetchedComments, @_handlePostsFetch

  _addListener: (eventName, callback) =>
    @_dispatcher.addListener eventName, callback, @

  _handlePostsFetch: ({data: {slug, comments}}) =>
    @_comments ||= {}
    for comment in comments
      @_comments[comment.id] = comment

    @_change()

  _change: ->
    @_dispatcher.dispatch 'change', null

module.exports = Comments