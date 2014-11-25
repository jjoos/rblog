# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/capacitor/src/capacitor.coffee'

module.exports = React.createClass
  displayName: 'Post'

  render: ->
    <article>
      <h2>{@props.post.title}</h2>
      <p>{@props.post.body}</p>
    </article>
