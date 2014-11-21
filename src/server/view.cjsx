# @jsx React.DOM
React = require 'react'

files = require '../util/files.coffee'

View = require '../view.cjsx'

class ServerView extends View
  @renderView: (component, options) ->
    files.getFile 'assets/template.html', (template) ->
      html = React.renderComponentToString component
      html = template.data.replace '<body />', "<body>#{html}</body>"
      options.response.writeHead 200, 'Content-Type': 'text/html'
      options.response.end html

module.exports = ServerView