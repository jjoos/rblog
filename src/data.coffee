class Data
  post: (slug) ->
    for _, post of @_posts
      return post if post.slug == slug

  posts: ->
    post for _, post of @_posts

  commentsForSlug: (slug) ->
    @_posts[slug]['comments']

module.exports = Data