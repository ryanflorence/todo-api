request = require 'request'
app = require "#{__dirname}/../app/app"
api = "http://localhost:#{app.address().port}"

createList = (done) ->
  request.post
    url: "#{api}/lists"
    json: true
    body:
      name: 'test list'
  , done

createItem = (done) ->
  createList (err, res, list) ->
    request.post
      url: "#{api}/lists/#{list.id}/items"
      json: true
      body:
        item:
          title: 'new item'
          complete: false
    , done

describe 'List API:', ->

  describe 'GET /lists', ->
    it 'should be empty at startup', (done) ->
      request.get
        url: "#{api}/lists"
        json: true
      , (err, res, body) ->
        body.should.eql []
        res.statusCode.should.equal 200
        done()

  describe 'POST /lists', ->
    it 'should create a list', (done) ->
      createList (err, res, body) ->
        body.name.should.equal 'test list'
        res.statusCode.should.equal 201
        done()

  describe 'GET /lists/:listID', ->
    it 'should read a list', (done) ->
      createList (err, res, newList) ->
        request.get
          url: "#{api}/lists/#{newList.id}"
          json: true
        , (err, res, list) ->
          list.name.should.equal 'test list'
          list.should.have.property('id').with.lengthOf 40
          done()

  describe 'DELETE /lists/:listID', ->
    it 'should delete a list', (done) ->
      createList (err, res, list) ->
        request.del
          url: "#{api}/lists/#{list.id}"
          json: true
        , (err, res, body) ->
          body.should.equal 'ok'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid list ids', (done) ->
      request.del
        url: "#{api}/lists/under21"
        json: true
      , (err, res, body) ->
        body.should.equal 'list not found'
        res.statusCode.should.equal 404
        done()

  describe 'PUT /lists/:listID', ->
    it 'should update a list and return it', (done) ->
      createList (err, res, newList) ->
        request.put
          url: "#{api}/lists/#{newList.id}"
          json: true
          body: name: 'new name'
        , (err, res, list) ->
          list.name.should.equal 'new name'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid list ids', (done) ->
      request.put
        url: "#{api}/lists/under21"
        json: true
      , (err, res, body) ->
        body.should.equal 'list not found'
        res.statusCode.should.equal 404
        done()

  describe 'POST /lists/:listID/items/:itemID', ->
    it 'should create an item', (done) ->
      createItem (err, res, item) ->
        item.title.should.equal 'new item'
        item.complete.should.equal false
        res.statusCode.should.equal 201
        done()

  describe 'GET /lists/:listID/items/:itemID', ->
    it 'should read an item', (done) ->
      createItem (err, res, newItem) ->
        request.get
          url: api + newItem.path
          json: true
        , (err, res, item) ->
          item.title.should.equal 'new item'
          item.complete.should.equal false
          res.statusCode.should.equal 200
          done()

  describe 'DEL /lists/:listID/items/:itemID', ->
    it 'should delete an item', (done) ->
      createItem (err, res, item) ->
        request.del
          url: api + item.path
          json: true
        , (err, res, body) ->
          body.should.equal 'item deleted'
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid ids', (done) ->
      request.del
        url: "#{api}/lists/fakeid/items/fakeid"
        json: true
      , (err, res, body) ->
        body.should.equal 'list or item not found'
        res.statusCode.should.equal 404
        done()


  describe 'PUT /lists/:listID/items/:itemID', ->
    it 'should update an item', (done) ->
      createItem (err, res, newItem) ->
        request.put
          url: api + newItem.path
          json: true
          body:
            item:
              title: 'new item title'
              complete: true
        , (err, res, item) ->
          item.title.should.equal 'new item title'
          item.complete.should.equal true
          res.statusCode.should.equal 200
          done()

    it 'should 404 on invalid ids', (done) ->
      request.put
        url: "#{api}/lists/fakeid/items/fakeid"
        json: true
      , (err, res, body) ->
        body.should.equal 'list or item not found'
        res.statusCode.should.equal 404
        done()

