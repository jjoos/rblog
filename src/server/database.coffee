pg = require 'pg'

conString = "postgres://localhost:3100/hackerone_development"
pg.connect conString, (err, client, done) ->
  return console.error("error fetching client from pool", err) if err

  client.query "SELECT * FROM users", (err, result) ->  
    done()
    return console.error("error running query", err) if err

    console.log result.rows