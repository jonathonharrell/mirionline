path = require "path"
_ = require "lodash"

all =
  env: process.env.NODE_ENV
  root: path.normalize __dirname + "/../../.."
  port: process.env.PORT || 9000
  mongo:
    options:
      db:
        safe: true

module.exports = exports = _.merge all, require("./" + all.env + ".coffee") or {}