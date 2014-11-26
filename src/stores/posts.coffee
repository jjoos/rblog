{Store} = require './../../vendor/eightyeight/src/eightyeight.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'posts'

  constructor: (dispatcher) ->
    @_dispatcher = dispatcher

    @_addListener constants.posts.fetched, @_handleFetchedPosts

    @_posts ||= {}

  data: ->
    if @_posts_fetched
      state: 'success'
      posts: (post for _, post of @_posts)
    else
      state: 'loading'

  _handleFetchedPosts: ({data: {posts}}) =>
    for post in posts
      @_posts[post.slug] = post

    @_posts_fetched = true

    @_change()
