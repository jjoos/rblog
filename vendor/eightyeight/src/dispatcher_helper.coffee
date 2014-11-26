React = require 'react'

Dispatcher = require './dispatcher.coffee'

module.exports =
  childContextTypes:
    dispatcher: React.PropTypes.object

  contextTypes:
    dispatcher: React.PropTypes.object

  componentWillMount: ->
    unless @getDispatcher()?
      componentName = @constructor.displayName || "component without display name"
      console.error "Could not find dispatcher in @props or @context of #{componentName}"

  getChildContext: ->
    dispatcher: @getDispatcher()

  getDispatcher: ->
    @props.dispatcher || (@context && @context.dispatcher)

  actions: (name) ->
    @getDispatcher().actions(name)

  data: (name) ->
    @getDispatcher().store(name).data()
