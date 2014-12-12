# Express configuration

'use strict'

mailer = require "nodemailer"
path   = require "path"
config = require "./environment"
stubTransport = require "nodemailer-stub-transport"
sgTransport   = require "nodemailer-sendgrid-transport"

options =
  auth:
    api_user: config.sendgrid.user || ''
    api_key:  config.sendgrid.key  || ''

module.exports = (app) ->
  env = app.get "env"

  transport = undefined
  transport = mailer.createTransport sgTransport(options) if env is "production"
  transport = mailer.createTransport stubTransport() if env is "test" or env is "development"

  app.use (req, res, next) ->
    req.mailer = transport
