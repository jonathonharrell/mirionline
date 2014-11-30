###
Main application routes
###

"use strict"

module.exports = (app) ->
  # Insert routes below
  app.use "/api/users", require("./api/user")

  app.use "/auth", require("./auth")
  
  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get (req, res) ->
    res.send 404
  
  # All other routes should redirect to the index.html
  app.route("/*").get (req, res) ->
    res.sendfile app.get("appPath") + "/index.html"
