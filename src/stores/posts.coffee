{Store} = require './../../vendor/capacitor/src/capacitor.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'posts'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_registerEventHandlers()
    
    @_posts ||= {}

  _registerEventHandlers: ->
    @_addListener constants.posts.fetched, @_handleFetchedPosts

  data: ->
    if @_posts_fetched
      state: 'success'
      data: (post for _, post of @_posts)
    else
      state: 'loading'

  _handleFetchedPosts: ({data: {posts}}) =>
    for post in posts
      @_posts[post.slug] = post

    @_posts_fetched = true

    @_change()
