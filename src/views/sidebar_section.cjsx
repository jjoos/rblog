{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

module.exports = React.createClass
  displayName: 'SidebarSection'

  mixins: [DispatcherHelper]

  render: ->
    <section id={@props.id}>
      <h3>{@props.title}</h3>
      {@props.children}
    </section>
