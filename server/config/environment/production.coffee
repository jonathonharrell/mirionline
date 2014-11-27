module.exports = 
  ip: process.env.IP or undefined
  port: process.env.PORT or 8080
  mongo:
    uri: process.env.MONGOHQ_URL or process.env.MONGOHQ_URL or "mongodb://localhost/miri"