{DispatcherHelper, React} = require './../../vendor/eightyeight/src/eightyeight.coffee'

BlogLayout = require './blog_layout.cjsx'
Comments = require './comments.cjsx'
NewComment = require './new_comment.cjsx'

module.exports = React.createClass
  displayName: 'Post'

  mixins: [DispatcherHelper]

  render: ->
    <BlogLayout>
      <article>
        <h2>{@data('post').post.title}</h2>
        <p>{@data('post').post.body}</p>
      </article>
      <Comments />
      <NewComment />
    </BlogLayout>
