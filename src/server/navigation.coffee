Q = require 'q'
React = require 'react'

Navigation = require '../actions/navigation.coffee'
Dispatcher = require '../dispatcher.coffee'
files = require '../util/files.coffee'

Dispatcher.registerActionClass class extends Navigation
  _render: (action, getComponent, options) ->
    if action?
      Q.spawn =>
        yield action()

        @_renderComponent getComponent, options
    else
      @_renderComponent getComponent, options

  _renderComponent: (getComponent, options) ->
    files.getFile 'assets/template.html', (template) ->
      html = React.renderComponentToString getComponent()
      html = template.data.replace '<body />', "<body>#{html}</body>"
      options.response.writeHead 200, 'Content-Type': 'text/html'
      options.response.end html
