class Data
  post: (slug) ->
    for _, post of @_posts
      console.info post.slug, slug
      return post if post.slug == slug

  posts: ->
    post for _, post of @_posts

  commentsForSlug: (slug) ->
    @_posts[slug]['comments']

module.exports = Data