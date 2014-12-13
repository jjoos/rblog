React = require 'react'

Navigation = require '../actions/navigation'
Dispatcher = require '../dispatcher'

Dispatcher.registerActionClass class extends Navigation
  _render: (action, getComponent, options) ->
    if action?
      @_dispatcher.addListener 'change', @_renderComponent(getComponent), 'render'

      action()
    else
      @_renderComponent(getComponent)()

  _renderComponent: (getComponent) -> ->
    React.renderComponent getComponent(), window.document.body
