{Helper} = require 'onehundredfourtytwo'
React = require 'react'

module.exports = class SidebarSection extends React.Component
  render: ->
    <section id={@props.id}>
      <h3>{@props.title}</h3>
      {@props.children}
    </section>
