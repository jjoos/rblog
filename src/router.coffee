router = class Router
  routeRegexes: ->
    index: /^\/?$/
    about: /^\/?about$/
    archive: /^\/?archives$/
    post: /^\/?posts\/([A-Za-z0-9\-]+)$/

  constructor: (data, view) ->
    @data = data
    @view = view

  index: (options) ->
    update = => @data.updatePosts()
    render = => @view.renderIndex(@data, options)

    @wrapper update, render

  post: (slug, options) ->
    update = => @data.updatePost(slug)
    render = => @view.renderPost(@data, slug, options)
    
    @wrapper update, render

  about: (options) ->
    @wrapper null, => @view.renderAbout(@data, options)

  archive: (options) ->
    @wrapper null, => @view.renderArchive(@data, options)

  wrapper: (update, render) ->
    if update?
      update()

      @data.addListener 'change', ->
        render()
    else
      render()

module.exports = Router