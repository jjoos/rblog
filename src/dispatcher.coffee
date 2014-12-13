{Dispatcher} = require 'onehundredfourtytwo'

Dispatcher.registerStoreClass require('./stores/comment_draft')
Dispatcher.registerStoreClass require('./stores/posts')
Dispatcher.registerStoreClass require('./stores/post')
Dispatcher.registerStoreClass require('./stores/navigation')
Dispatcher.registerActionClass require('./actions/posts')
Dispatcher.registerActionClass require('./actions/comment_draft')

module.exports = Dispatcher
