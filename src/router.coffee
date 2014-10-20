router = class Router
  routeRegexes: ->
    index:
      regex: /\//
      callback: 'showIndex'
    about:
      regex: /about/
      callback: 'showAbout'
    archive:
      regex: /archives/
      callback: 'showArchives'
    post:
      regex: /posts\/([A-Za-z0-9\-]+)/
      callback: 'showPost'

  constructor: (data, view) ->
    @data = data
    @view = view

  showIndex: (options) ->
    yield @data.updatePosts()
    @view.renderIndex(@data, options)

  showPost: (slug, options) ->
    @data.updatePost(slug)
    @views.renderPost(@data, slug, options)

  showAbout: (options) ->
    @views.renderAbout()

  showArchives: (options) ->
    @views.renderArchives()

module.exports = Router