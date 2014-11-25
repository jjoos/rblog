# @jsx React.DOM
{DispatcherHelper, React} = require './../../vendor/capacitor/src/capacitor.coffee'

Summary = require './summary.cjsx'

module.exports = React.createClass
  displayName: 'Index'

  posts: ->
    for post in @props.posts
      <Summary
        post={post}
        key={post.slug} />

  render: ->
    <div>
      {@posts()}
    </div>
