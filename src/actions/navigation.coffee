{Actions} = require 'onehundredfourtytwo'
Q = require 'q'
request = require 'superagent'
require('q-superagent') request

constants = require './../constants'
View = require('./../view')

module.exports = class extends Actions
  actionName: 'navigation'

  index: (options) ->
    action = => @_dispatcher.actions('posts').fetchPosts()
    renderComponent = => View.renderIndex @_dispatcher

    @_dispatcher.dispatch(constants.navigation.index).then =>
      @_render action, renderComponent, options

  post: (slug, options) ->
    action = => @_dispatcher.actions('posts').fetchPost(slug)
    renderComponent = => View.renderPost @_dispatcher

    @_dispatcher.dispatch(constants.navigation.post, slug: slug).then =>
      @_render action, renderComponent, options

  about: (options) ->
    renderComponent = => View.renderAbout @_dispatcher

    @_dispatcher.dispatch(constants.navigation.about).then =>
      @_render null, renderComponent, options

  archive: (options) ->
    renderComponent = => View.renderArchive @_dispatcher

    @_dispatcher.dispatch(constants.navigation.archive).then =>
      @_render null, renderComponent, options
