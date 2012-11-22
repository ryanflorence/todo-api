request = require 'request'
app = require "#{__dirname}/../app/app"
api = "http://localhost:#{app.address().port}"

createList = (done) ->
  request.post
    url: "#{api}/lists"
    json: true
    body: list: name: 'test list'
  , done

createItem = (done) ->
  createList (err, res, {list}) ->
    request.post
      url: "#{api}/items"
      json: true
      body:
        item:
          title: 'new item'
          complete: false
          list_id: list.id
    , done

describe 'List API:', ->

  describe 'GET /lists', ->
    it 'should have a Christmas list at startup', (done) ->
      request.get
        url: "#{api}/lists"
        json: true
      , (err, res, body) ->
        body.should.eql {lists:[{id: 1, name: 'Christmas List'}]}
        res.statusCode.should.equal 200
        done()

  describe 'POST /lists', ->
    it 'should create a list', (done) ->
      createList (err, res, body) ->
        body.list.name.should.equal 'test list'
        res.statusCode.should.equal 201
        done()

  describe 'GET /lists/:list_id', ->
    it 'should read a list', (done) ->
      createList (err, res, {list}) ->
        request.get
          url: "#{api}/lists/#{list.id}"
          json: true
        , (err, res, {list}) ->
          list.name.should.equal 'test list'
          list.should.have.property('id')
          done()

  describe 'DELETE /lists/:list_id', ->
    it 'should delete a list', (done) ->
      createList (err, res, {list}) ->
        request.del
          url: "#{api}/lists/#{list.id}"
          json: true
        , (err, res, body) ->
          body.should.equal 'list deleted'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid list ids', (done) ->
      request.del
        url: "#{api}/lists/under21"
        json: true
      , (err, res, body) ->
        body.should.equal 'Error: list with id under21 not found.'
        res.statusCode.should.equal 404
        done()

  describe 'PUT /lists/:list_id', ->
    it 'should update a list and return it', (done) ->
      createList (err, res, {list}) ->
        request.put
          url: "#{api}/lists/#{list.id}"
          json: true
          body: name: 'new name'
        , (err, res, {list}) ->
          list.name.should.equal 'new name'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid list ids', (done) ->
      request.put
        url: "#{api}/lists/under21"
        json: true
      , (err, res, body) ->
        body.should.equal 'Error: list with id under21 not found.'
        res.statusCode.should.equal 404
        done()

  describe 'POST /items', ->
    it 'should create an item', (done) ->
      createItem (err, res, {item}) ->
        item.title.should.equal 'new item'
        item.complete.should.equal false
        item.should.have.property 'list_id'
        res.statusCode.should.equal 201
        done()

  describe 'GET /items/:item_id', ->
    it 'should read an item', (done) ->
      createItem (err, res, {item}) ->
        request.get
          url: "#{api}/items/#{item.id}"
          json: true
        , (err, res, {item}) ->
          item.title.should.equal 'new item'
          item.complete.should.equal false
          res.statusCode.should.equal 200
          done()

  describe 'DEL /items/:item_id', ->
    it 'should delete an item', (done) ->
      createItem (err, res, {item}) ->
        request.del
          url: "#{api}/items/#{item.id}"
          json: true
        , (err, res, body) ->
          body.should.equal 'item deleted'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid ids', (done) ->
      request.del
        url: "#{api}/items/fakeid"
        json: true
      , (err, res, body) ->
        body.should.equal 'Error: item with id fakeid not found.'
        res.statusCode.should.equal 404
        done()

  describe 'PUT /items/:item_id', ->
    it 'should update an item', (done) ->
      createItem (err, res, {item}) ->
        request.put
          url: "#{api}/items/#{item.id}"
          json: true
          body:
            item:
              title: 'new item title'
              complete: true
        , (err, res, {item}) ->
          item.title.should.equal 'new item title'
          item.complete.should.equal true
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid ids', (done) ->
      request.put
        url: "#{api}/items/fakeid"
        json: true
      , (err, res, body) ->
        body.should.equal 'Error: item with id fakeid not found.'
        res.statusCode.should.equal 404
        done()

