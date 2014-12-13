{Store} = require 'onehundredfourtytwo'

constants = require './../constants'

module.exports = class extends Store
  storeName: 'post'

  constructor: (dispatcher) ->
    super

    @_addListener constants.post.fetchedComments, @_handleFetchedCommentsForPost
    @_addListener constants.post.fetched, @_handleFetchedPost

    @_post = {}
    @_comments = []
    @_loading_comments = true
    @_loading_post = true

  data: ->
    {slug} = @_dispatcher.store('navigation').data()

    loading: @_loading_post || @_loading_comments
    post: @_post
    comments: @_comments

  _handleFetchedCommentsForPost: ({data: {slug, comments}}) =>
    @_comments = comments
    @_loading_comments = false

    @_change()

  _handleFetchedPost: ({data: {slug, post}}) =>
    @_post = post
    @_loading_post = false

    @_change()
