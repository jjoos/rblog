Sequelize = require 'sequelize'

require '../util/configuration'

port = process.env.DATABASE_PORT
host = process.env.DATABASE_HOST
sequelize =
  new Sequelize 'rblog_development', '', '',
    host: host
    port: port
    logging: false
    dialect: 'postgres'

sequelize
  .authenticate()
  .complete (err) ->
    if !!err
      console.log 'Unable to connect to the database:', err
    else
      console.log 'Connection has been established successfully.'

Post = sequelize.define 'Post',
  slug: Sequelize.STRING
  title: Sequelize.STRING
  author: Sequelize.STRING
  tags: Sequelize.ARRAY(Sequelize.TEXT)
  body: Sequelize.TEXT

Comment = sequelize.define 'Comment',
  author: Sequelize.STRING
  body: Sequelize.TEXT

Post.hasMany Comment

db =
  sequelize: sequelize
  Post: Post
  Comment: Comment

module.exports = db
