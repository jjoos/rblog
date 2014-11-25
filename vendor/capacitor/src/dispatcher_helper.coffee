React = require 'react'

Dispatcher = require './dispatcher.coffee'

module.exports =
  propTypes:
    dispatcher: React.PropTypes.instanceOf(Dispatcher)

  actions: (name) ->
    @props.dispatcher.actions(name)

  data: (name) ->
    @props.dispatcher.store(name).data()
