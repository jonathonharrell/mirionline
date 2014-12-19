"use strict"

require "coffee-script/register"

# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or "development"
express    = require "express"
bodyParser = require "body-parser"
fs         = require "fs"
path       = require "path"

app = express()
server = require("http").createServer(app)

app.set "views", __dirname
app.set "view engine", "jade"

app.use bodyParser.urlencoded({ extended: false })
app.use bodyParser.json()

app.route("/").get (req, res) ->
  dataPath = path.normalize __dirname + "/../../.data/names.json"
  fs.readFile dataPath, (err, data) ->
    data = JSON.parse data
    res.render "browse", {names: data.names}

app.route("/save").post (req, res, next) ->
  content = JSON.stringify { names: req.body }
  dataPath = path.normalize __dirname + "/../../.data/names.json"
  fs.writeFile dataPath, content, (err) ->
    console.log err if err
    res.status(204).end()

startServer = ->
  server.listen 9000, '127.0.0.1', ->
    console.log "Express server listening on %d, in %s mode", 9000, app.get("env")

setImmediate startServer
