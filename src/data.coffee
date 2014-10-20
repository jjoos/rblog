class Data
  @post: (slug) ->
    @_posts[slug]

  @posts: ->
    @_posts

  @commentsForPost: (slug) ->
    _(@_posts[slug]['comments']).map (comment_id) ->
      @_comments[id]

module.exports = Data