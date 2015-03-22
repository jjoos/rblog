Q = require 'q'
React = require 'react'

Navigation = require '../actions/navigation'
Dispatcher = require '../dispatcher'
fs = require 'fs'

getTemplate = (callback) ->
  fs.readFile 'assets/template.html', encoding: 'utf8', (error, data) ->
    return console.log error if error

    callback data

Dispatcher.registerActionClass class extends Navigation
  _render: (action, getComponent, options) ->
    if action?
      Q.spawn =>
        yield action()

        @_renderComponent getComponent, options
    else
      @_renderComponent getComponent, options

  _renderComponent: (getComponent, options) ->
    getTemplate (template) ->
      html = React.renderToString getComponent()
      html = template.replace '<body />', "<body>#{html}</body>"
      options.response.writeHead 200, 'Content-Type': 'text/html'
      options.response.end html
