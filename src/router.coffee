router = class Router
  routeRegexes: ->
    index: /^\/?$/
    about: /^\/?about$/
    archive: /^\/?archives$/
    post: /^\/?posts\/([A-Za-z0-9\-]+)$/

  constructor: (dispatcher, view) ->
    @dispatcher = dispatcher
    @view = view

  index: (options) ->
    action = => @dispatcher.actions('posts').fetchPosts()
    render = => @view.renderIndex(@dispatcher, options)

    @wrapper action, render

  post: (slug, options) ->
    action = => @dispatcher.actions('posts').fetchPost(slug)
    render = => @view.renderPost(@dispatcher, slug, options)
    
    @wrapper action, render

  about: (options) ->
    @wrapper null, => @view.renderAbout(@dispatcher, options)

  archive: (options) ->
    @wrapper null, => @view.renderArchive(@dispatcher, options)

module.exports = Router