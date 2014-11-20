constants = require './../constants.coffee'

class Comments
  storeName: 'comments'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()

  _registerEventHandlers: ->
    @_addListener constants.events.fetchPosts, @_handleFetchedCommentsForPost

  _addListener: => @_dispatcher.addListener

  _handleFetchedCommentsForPost: ({data: {slug, comments}}) =>
    @_comments ||= {}
    for comment in comments
      @_comments[comment.id] = comment

    @_change()

  _change: ->
    @_dispatcher.emitEvent 'change'

module.exports = Comments