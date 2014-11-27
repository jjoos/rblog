{Helper} = require 'onehundredfourtytwo'
React = require 'react'

module.exports = React.createClass
  displayName: 'SidebarSection'

  mixins: [Helper]

  render: ->
    <section id={@props.id}>
      <h3>{@props.title}</h3>
      {@props.children}
    </section>
