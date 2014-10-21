class Data
  post: (slug) ->
    @_posts[slug]

  posts: ->
    @_posts

module.exports = Data