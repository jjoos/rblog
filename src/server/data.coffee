db = require './database.coffee'
Data = require '../data.coffee'

class ServerData extends Data
  @updatePosts: =>
    db.Post.findAll().then (posts) =>
      @_posts = (post.dataValues for post in posts)

  @updatePost: =>
    db.Post.find(where: {'slug': slug}).then (post) =>
      @_posts[slug] = post

  # TODO: rewrite with promises or SYNC
  @posts: ->
    @_posts

  @post: (slug) ->
    @_posts[slug]

module.exports = ServerData