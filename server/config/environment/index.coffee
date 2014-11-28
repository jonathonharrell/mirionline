path = require "path"
_ = require "lodash"

all =
  env: process.env.NODE_ENV or "development"
  root: path.normalize __dirname + "/../../.."
  port: process.env.PORT || 9000
  mongo:
    options:
      db:
        safe: true
  secrets:
    session: "EsMUwRCxL3zUZ8QJKMfUbC95"
  session:
    options: { expiresInMinutes: 60 * 12 }

module.exports = exports = _.merge all, require("./" + all.env + ".coffee") or {}
