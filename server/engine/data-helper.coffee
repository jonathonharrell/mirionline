'use strict'

config = require "../config/environment"
path   = require "path"

DataHelper =
  import: (filename) ->
    return require path.join(config.root, ".data", filename + ".json")

module.exports = exports = DataHelper
