class Posts
  storeName: 'posts'

  eventHandlers: ->
    fetchedCommentsForPost: @_handleFetchedCommentsForPost
    fetchedPost: @_handleFetchedPost
    fetchedPosts: @_handleFetchedPosts
   
  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    for eventName, handler of @eventHandlers()
      dispatcher.addListener eventName, handler
    
    @_posts ||= {}

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

  _change: ->
    @_dispatcher.emitEvent 'change'

module.exports = Posts