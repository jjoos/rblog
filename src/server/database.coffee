require './configuration.coffee'
Sequelize = require 'sequelize'

sequelize =
  new Sequelize "postgres://#{process.env.DATABASE_HOST}:"+
    "#{process.env.DATABASE_PORT}/rblog_development"

sequelize
  .authenticate()
  .complete (err) ->
    if !!err
      console.log 'Unable to connect to the database:', err
    else
      console.log 'Connection has been established successfully.'

post = sequelize.define 'Post',
    slug: Sequelize.STRING
    title: Sequelize.STRING
    author: Sequelize.STRING
    tags: Sequelize.ARRAY(Sequelize.TEXT)
    body: Sequelize.TEXT

db =
  sequelize: sequelize
  Post: post

module.exports = db
