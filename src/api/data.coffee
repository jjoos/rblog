db = require './database.coffee'
Q = require 'q'

class Data
  updatePosts: ->
    async = Q.async =>
      @_posts ||= {}
      posts = yield db.Post.findAll()
      for post in posts
        post = post.dataValues
        @_posts[post.id] = post

    async()

  updatePost: (slug) ->
    async = Q.async =>
      @_posts ||= {}
      post = yield db.Post.find where: {'slug': slug}
      post = post.dataValues
      @_posts[slug] = post
      @_posts[slug]['comments'] = []
      comments = yield db.Comment.where('PostId': post.id).exec()
      comments ||= []

      @_posts[slug]['comments'] = comments.map (comment) -> comment.dataValues

      for comment in @_posts[slug]['comments']
        @_comments ||= {}
        @_comments[comment.id] = comment

    async()

  post: (slug) ->
    for _, post of @_posts
      return post if post.slug == slug

  posts: ->
    post for _, post of @_posts

  commentsForSlug: (slug) ->
    @_posts[slug]['comments']

module.exports = Data