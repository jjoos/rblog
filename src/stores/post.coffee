{Store} = require './../../vendor/eightyeight/src/eightyeight.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'post'

  constructor: (dispatcher) ->
    super

    @_addListener constants.post.fetchedComments, @_handleFetchedCommentsForPost
    @_addListener constants.post.fetched, @_handleFetchedPost

    @_posts ||= {}

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
