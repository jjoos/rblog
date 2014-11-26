# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

module.exports = React.createClass
  displayName: 'SidebarSection'

  render: ->
    <section id={@props.id}>
      <h3>{@props.title}</h3>
      {@props.children}
    </section>
