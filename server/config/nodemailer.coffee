# Express configuration

'use strict'

mailer = require "nodemailer"
path   = require "path"
config = require "./environment"
jade   = require "jade"
fs     = require "fs"
open   = require "open"
mkdirp = require "mkdirp"

stubTransport = require "nodemailer-stub-transport"
sgTransport   = require "nodemailer-sendgrid-transport"
htmlToText    = require("nodemailer-html-to-text").htmlToText

options =
  auth:
    api_user: config.sendgrid.user or ''
    api_key:  config.sendgrid.key  or ''

module.exports = (app) ->
  env = app.get "env"

  transport = undefined
  transport = mailer.createTransport sgTransport(options) if env is "production"
  transport = mailer.createTransport stubTransport() if env is "test" or env is "development"
  transport.use htmlToText()

  # todo -> move some of this to an external file in server/lib/ for independent testing

  templateDir = path.join config.root, "server", "views", "email"

  transport.sendMessage = (options, locals, callback) ->
    render = jade.compile fs.readFileSync(path.join(templateDir, options.template + ".jade"), "utf-8")
    html   = render locals
    email  =
      to: options.to
      from: 'no-reply@minimiri.com' # todo move to config file
      subject: options.subject
      html: html

    transport.sendMail email, (err, data) ->
      console.error err if err

      if env is "development"
        # open a preview of the message
        # not too worried about if this is async compliant or not, since it's dev only

        render = jade.compile fs.readFileSync(path.join(config.root, "server", "views", "dev", "email.preview.jade"), "utf-8")
        save   = render { message: data.response.toString() }

        dir = path.join(config.root, ".tmp", "mail", (new Date).toISOString().replace(/[-:TZ\.]/g, ''))
        mkdirp.sync dir

        filename = path.join dir, "message.html"
        fs.writeFileSync filename, save, 'utf-8'
        open filename

      callback?(err, data)

  app.use (req, res, next) ->
    req.mailer = transport
    next()
