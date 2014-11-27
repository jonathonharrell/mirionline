'use strict'

express = require "express"
favicon = require "serve-favicon"
compression = require "compression"
path = require "path"
config = require "./environment"

module.exports = (app) ->
  env = app.get "env"

  app.use compression()

  if env is "production"
    app.use favicon(path.join(config.root, "public", "favicon.ico"))
    app.use express.static(path.join(config.root, "public"))
    app.set "appPath", config.root + "/public"

  if env is "development" or env is "test"
    app.use require("connect-livereload")()
    app.use express.static(path.join(config.root, ".tmp"))
    app.use express.static(path.join(config.root, "client"))
    app.set "appPath", "client"