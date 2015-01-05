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
  namesPath = path.normalize __dirname + "/../../.data/names.json"
  fs.readFile dataPath, (err, data) ->
    fs.readFile namesPath, (err, names) ->
      data = JSON.parse data
      names = JSON.parse names
      res.render "main", {data: data, names: names}

app.route("/save").post (req, res, next) ->
  # race: { genders: {
  # "male": { "noble": { names: { "first": [], "titles": [] } } }
  # }. description: "", locked: false, "anotherkey":"whatever" }

  data = JSON.stringify req.body, null, 2
  dataPath = path.normalize __dirname + "/../../.data/character-creation"
  mkdirp dataPath, (err) ->
    fs.writeFile dataPath + "/data.json", data, (err) ->
      console.error err if err
      res.status(204).end()

startServer = ->
  server.listen 9000, '127.0.0.1', ->
    console.log "Express server listening on %d, in %s mode", 9000, app.get("env")

setImmediate startServer
