require './configuration.coffee'
Sequelize = require 'sequelize'

options =
  dialect: 'postgres'
  protocol: 'postgres'
  port: process.env.DATABASE_PORT
  host: process.env.DATABASE_HOST
  logging: false

sequelize = new Sequelize "postgres://#{process.env.DATABASE_HOST}:#{process.env.DATABASE_PORT}/rblog_development"

sequelize
  .authenticate()
  .complete (err) ->
    if !!err
      console.log 'Unable to connect to the database:', err
    else
      console.log 'Connection has been established successfully.'

post = sequelize.import 'Post', (sequelize, DataTypes) ->
  sequelize.define 'Post',
    name: DataTypes.STRING
    description: DataTypes.TEXT

db =
  sequelize: sequelize
  models:
    Post: post

module.exports = db

# conString = "postgres://localhost:3100/hackerone_development"
# pg.connect conString, (err, client, done) ->
#   return console.error("error fetching client from pool", err) if err

#   client.query "SELECT * FROM users", (err, result) ->  
#     done()
#     return console.error("error running query", err) if err

#     console.log result.rows
