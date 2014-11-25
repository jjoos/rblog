constants = require './../constants.coffee'

module.exports = class
  storeName: 'post'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()

    @_posts ||= {}

  _registerEventHandlers: ->
    @_addListener constants.post.fetchedComments, @_handleFetchedCommentsForPost
    @_addListener constants.post.fetched, @_handleFetchedPost

  data: ->
    {slug} = @_dispatcher.store('navigation').data()

    if @_posts[slug]?
      state: 'success'
      data: @_posts[slug]
    else
      state: 'loading'

  _handleFetchedCommentsForPost: ({data: {slug, comments}}) =>
    @_posts[slug] ||= {}
    @_posts[slug]['comments'] = comments

    @_change()

  _handleFetchedPost: ({data: {slug, post}}) =>
    @_posts[slug] = post

    @_change()

  _addListener: (eventName, handler) ->
    @_dispatcher.addListener eventName, handler, @storeName

  _change: ->
    @_dispatcher.dispatch 'change'
