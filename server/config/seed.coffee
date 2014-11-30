###*
  Populate DB with sample data on server start
  to disable, edit config/environment/index.js, and set `seedDB: false`
###

'use strict'

User = require "../api/user/user.model"

User.find({}).remove ->
  User.create
    provider: 'local',
    email: 'test@test.com',
    password: 'test'
  ,
    provider: 'local',
    role: 'admin',
    email: 'admin@admin.com',
    password: 'admin'
  , ->
      console.log "finished populating users"
