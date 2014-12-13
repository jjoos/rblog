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
    render = => View.renderIndex @_dispatcher

    @_dispatcher.dispatch(constants.navigation.index).then =>
      @_render action, render, options

  post: (slug, options) ->
    action = => @_dispatcher.actions('posts').fetchPost(slug)
    render = => View.renderPost @_dispatcher

    @_dispatcher.dispatch(constants.navigation.post, slug: slug).then =>
      @_render action, render, options

  about: (options) ->
    render = => View.renderAbout @_dispatcher

    @_dispatcher.dispatch(constants.navigation.about).then =>
      @_render null, render, options

  archive: (options) ->
    render = => View.renderArchive @_dispatcher

    @_dispatcher.dispatch(constants.navigation.archive).then =>
      @_render null, render, options
