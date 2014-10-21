db = require './database.coffee'
Data = require '../data.coffee'
Q = require 'q'

class ServerData extends Data
  updatePosts: ->
    async = Q.async =>
      posts = db.Post.findAll()
      for post in posts
        post = post.dataValues
        @_posts[post.id] = post

    async()

  updatePost: (slug) ->
    async = Q.async =>
      @_posts ||= {}
      post = yield db.Post.find where: {'slug': slug}
      post = post.dataValues
      @_posts[post.id] = post
      @_posts[post.id]['comments'] = yield db.Comment.find
        where: {'PostId': post.id}

      if @_posts[post.id]['comments']?
        for comment in @_posts[post.id]['comments']
          @_comments ||= {}
          @_comments[comment.id] = comment
    
    async()

module.exports = ServerData