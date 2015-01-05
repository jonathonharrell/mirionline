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
  cosmetic = path.normalize __dirname + "/../../.data/character-creation/cosmetic.json"
  fs.readFile dataPath, (err, data) ->
    fs.readFile cosmetic, (err, aesthetics) ->
      cosmetics = JSON.parse aesthetics
      data = JSON.parse data
      res.render "main", {data: data, cosmetics: cosmetics}

app.route("/save").post (req, res, next) ->
  # example =
  #   human:
  #     body:
  #       type: {}
  #       color: []
  #       detail: {}
  #     face:
  #       type: {}
  #       eyes:
  #         color: []
  #         type: {}
  #       detail: {}
  #     hair:
  #       color: []
  #       style: {} where objects in this case are { "name": "description" }

  data = JSON.stringify req.body, null, 2
  dataPath = path.normalize __dirname + "/../../.data/character-creation"
  mkdirp dataPath, (err) ->
    fs.writeFile dataPath + "/cosmetic.json", data, (err) ->
      console.error err if err
      res.status(204).end()

startServer = ->
  server.listen 9000, '127.0.0.1', ->
    console.log "Express server listening on %d, in %s mode", 9000, app.get("env")

setImmediate startServer
