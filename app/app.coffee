express = require 'express'
routes = require "#{process.cwd()}/app/routes"

app = module.exports = express.createServer()

app.configure ->
  app.use express.bodyParser()
  app.use (req, res, next) ->
    res.header 'Access-Control-Allow-Origin', '*'
    res.header 'Access-Control-Allow-Headers", "X-Requested-With'
    res.header 'Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS'
    res.header 'Access-Control-Allow-Headers', 'Content-Type'
    next()
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'production', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'test', ->
  app.use express.errorHandler()

app.get   '/lists',                       routes.allLists

app.post  '/lists',                       routes.createList
app.get   '/lists/:listID',               routes.getList
app.del   '/lists/:listID',               routes.deleteList
app.put   '/lists/:listID',               routes.updateList

app.post  '/lists/:listID/items',         routes.createItem
app.get   '/lists/:listID/items/:itemID', routes.getItem
app.del   '/lists/:listID/items/:itemID', routes.deleteItem
app.put   '/lists/:listID/items/:itemID', routes.updateItem

app.listen process.env.PORT
msg = 'Express server listening on port %d in %s mode'
console.log msg, app.address().port, app.settings.env
