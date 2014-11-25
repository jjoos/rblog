Navigation = require '../actions/navigation.coffee'
Dispatcher = require '../dispatcher.coffee'
React = require 'react'

Dispatcher.registerActionClass class extends Navigation
  _render: (action, getComponent, options) ->
    if action?
      @_dispatcher.addListener 'change', @_renderComponent(getComponent), 'render'

      action()
    else
      @_renderComponent(getComponent)()

  _renderComponent: (getComponent) -> ->
    React.renderComponent getComponent(), window.document.body
