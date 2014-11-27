{Dispatcher} = require 'onehundredfourtytwo'

Dispatcher.registerStoreClass require('./stores/comment_draft.coffee')
Dispatcher.registerStoreClass require('./stores/posts.coffee')
Dispatcher.registerStoreClass require('./stores/post.coffee')
Dispatcher.registerStoreClass require('./stores/navigation.coffee')
Dispatcher.registerActionClass require('./actions/posts.coffee')
Dispatcher.registerActionClass require('./actions/comment_draft.coffee')

module.exports = Dispatcher
