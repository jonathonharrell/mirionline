"use strict"

require "coffee-script/register"

# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or "development"
express    = require "express"
bodyParser = require "body-parser"
fs         = require "fs"
path       = require "path"
mkdirp     = require "mkdirp"

app = express()
server = require("http").createServer(app)

app.set "views", __dirname
app.set "view engine", "jade"

app.use bodyParser.urlencoded({ extended: false })
app.use bodyParser.json()

app.route("/").get (req, res) ->
  dataPath = path.normalize __dirname + "/../../.data/character-creation/data.json"
  namePath = path.normalize __dirname + "/../../.data/character-creation/names.json"
  fs.readFile dataPath, (err, data) ->
    fs.readFile namePath, (err, names) ->
      res.render "main", {data: JSON.parse(data), names: JSON.parse(names)}

app.route("/save").post (req, res, next) ->
  # example =
  #   human:
  #     male:     []
  #     female:   []
  #     unisex:   []
  #     surnames: []

  data = JSON.stringify req.body, null, 2
  dataPath = path.normalize __dirname + "/../../.data/character-creation"
  mkdirp dataPath, (err) ->
    fs.writeFile dataPath + "/names.json", data, (err) ->
      console.error err if err
      res.status(204).end()

startServer = ->
  server.listen 9000, '127.0.0.1', ->
    console.log "Express server listening on %d, in %s mode", 9000, app.get("env")

setImmediate startServer
