express = require 'express'
routes = require "#{process.cwd()}/app/routes"
lists = require "#{__dirname}/lists"
fixtures = require "#{__dirname}/fixtures"

app = module.exports = express.createServer()
app.lists = lists

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
  app.use express.errorHandler()

app.configure 'test', ->
  app.use express.errorHandler()

fixtures.load()

app.get   '/',               routes.home

app.get   '/lists',          routes.allLists

app.post  '/lists',          routes.createList
app.get   '/lists/:list_id', routes.getList
app.del   '/lists/:list_id', routes.deleteList
app.put   '/lists/:list_id', routes.updateList

app.post  '/items',          routes.createItem
app.get   '/items/:item_id', routes.getItem
app.del   '/items/:item_id', routes.deleteItem
app.put   '/items/:item_id', routes.updateItem

app.listen process.env.PORT or 5000
msg = 'Express server listening on port %d in %s mode'
console.log msg, app.address().port, app.settings.env
