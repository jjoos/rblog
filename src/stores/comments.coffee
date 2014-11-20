class Comments
  storeName: 'comments'

  eventHandlers: ->
    fetchedCommentsForPost: @_handleFetchedCommentsForPost
   
  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    for eventName, handler of @eventHandlers()
      dispatcher.addListener eventName, handler

  _handleFetchedCommentsForPost: ({data: {slug, comments}}) =>
    @_comments ||= {}
    for comment in comments
      @_comments[comment.id] = comment

    @_change()

  _change: ->
    @_dispatcher.emitEvent 'change'

module.exports = Comments