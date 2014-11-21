# @jsx React.DOM
React = require 'react'

module.exports = React.createClass
  displayName: 'SidebarSection'

  render: ->
    <section id={@props.id}>
      <h3>{@props.title}</h3>
      {@props.children}
    </section>
