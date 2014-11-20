constants = require './../constants.coffee'

class Posts
  storeName: 'posts'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()
    
    @_posts ||= {}

  _registerEventHandlers: ->
    @_addListener constants.events.fetchedCommentsForPost, @_handleFetchedCommentsForPost
    @_addListener constants.events.fetchedPost, @_handleFetchedPost
    @_addListener constants.events.fetchedPosts, @_handleFetchedPosts

  post: (slug) ->
    if @_posts[slug]?
      state: 'success'
      data: @_posts[slug]
    else
      state: 'loading'

  posts: ->
    if @_posts_fetched
      state: 'success'
      data: (post for _, post of @_posts)
    else
      state: 'loading'

  _handleFetchedCommentsForPost: ({data: {slug, comments}}) =>
    @_posts[slug] ||= {}
    @_posts[slug]['comments'] = comments

    @_change()

  _handleFetchedPost: ({data: {slug, post}}) =>
    @_posts[slug] = post

    @_change()

  _handleFetchedPosts: ({data: {posts}}) =>
    for post in posts
      @_posts[post.slug] = post

    @_posts_fetched = true

    @_change()

  _addListener: (eventName, handler) ->
    @_dispatcher.addListener eventName, handler

  _change: ->
    @_dispatcher.emitEvent 'change'

module.exports = Posts