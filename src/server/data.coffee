db = require './database.coffee'
Data = require '../data.coffee'

class ServerData extends Data
  updatePosts: =>
    db.Post.findAll().then (posts) =>
      @_posts = (post.dataValues for post in posts)

  updatePost: (slug) =>
    @_posts ||= {}
    db.Post.find(where: {'slug': slug}).then (post) =>
      @_posts[slug] = post

module.exports = ServerData