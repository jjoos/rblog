router = class Router
  routeRegexes: ->
    index:
      regex: /^\/?$/
      callback: 'showIndex'
    about:
      regex: /^\/?about$/
      callback: 'showAbout'
    archive:
      regex: /^\/?archives$/
      callback: 'showArchives'
    post:
      regex: /^\/?posts\/([A-Za-z0-9\-]+)$/
      callback: 'showPost'

  constructor: (data, view) ->
    @data = data
    @view = view

  showIndex: (options) ->
    @data.updatePosts()
    if @data.posts()?
      @view.renderIndex(@data, options)

    @data.on 'change', =>
      @view.renderIndex(@data, options)

  showPost: (slug, options) ->
    @data.updatePost(slug)
    if @data.post(slug)?
      @view.renderPost(@data, slug, options)

    @data.on 'change', =>
      @view.renderPost(@data, slug, options)

  showAbout: (options) ->
    @view.renderAbout()

  showArchives: (options) ->
    @view.renderArchives()

module.exports = Router