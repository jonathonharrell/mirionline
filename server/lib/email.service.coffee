# Mailer extra methods (includes dev tools for "letter opener")

'use strict'

mailer = require "nodemailer"
path   = require "path"
jade   = require "jade"
fs     = require "fs"
open   = require "open"
mkdirp = require "mkdirp"
config = require "../config/environment"

sgOptions =
  auth:
    api_user: config.sendgrid.user or ''
    api_key:  config.sendgrid.key  or ''

stubTransport = require "nodemailer-stub-transport"
sgTransport   = require "nodemailer-sendgrid-transport"
htmlToText    = require("nodemailer-html-to-text").htmlToText

module.exports = (env) ->
  transport = undefined
  transport = mailer.createTransport sgTransport(sgOptions) if env is "production"
  transport = mailer.createTransport stubTransport() if env isnt "production"
  transport.use htmlToText()

  templateDir = path.join __dirname, "views", "email"

  transport.sendMessage = (options, callback) ->
    try
      render = jade.compile fs.readFileSync(path.join(templateDir, options.template + ".jade"), "utf-8")
      html   = render(options.locals or {})
    catch e
      return callback? e, null

    email  =
      to: options.to
      from: 'no-reply@minimiri.com' # todo move to config file
      subject: options.subject or 'No Subject'
      html: html

    transport.sendMail email, (err, data) ->
      console.error err if err

      if env is "development"
        # open a preview of the message
        # not too worried about if this is async friendly or not, since it's dev only

        render = jade.compile fs.readFileSync(path.join(__dirname, "views", "email.preview.jade"), "utf-8")
        save   = render { message: data.response.toString().replace(/(?:\r\n|\r|\n)/g, "<br/>") }

        dir = path.join(config.root, ".tmp", "mail", (new Date).toISOString().replace(/[-:TZ\.]/g, ''))
        mkdirp.sync dir

        filename = path.join dir, "message.html"
        fs.writeFileSync filename, save, 'utf-8'
        open filename

      callback?(err, data)

  transport
