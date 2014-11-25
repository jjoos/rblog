Navigation = require '../actions/navigation.coffee'
Dispatcher = require '../dispatcher.coffee'
React = require 'react'

class ClientNavigation extends Navigation
  _render: (action, getComponent, options) ->
    if action?
      @_dispatcher.addListener 'change', @_renderComponent(getComponent), {storeName: 'stub'}

      action()
    else
      _renderComponent(getComponent)()

  _renderComponent: (getComponent) -> ->
    React.renderComponent getComponent(), window.document.body

Dispatcher.registerActionClass ClientNavigation