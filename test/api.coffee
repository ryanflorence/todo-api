request = require 'request'
api = 'http://localhost:5000'

describe 'List API:', ->

  describe 'GET /lists', ->

    it 'should return an empty object with no items on startup', (done) ->
      request.get
        url: "#{api}/lists"
        json: true
      , (err, res, body) ->
        body.should.eql {}
        res.statusCode.should.equal 200
        done()

  describe 'POST /lists', ->
    it 'should create a list', (done) ->
      request.post
        url: "#{api}/lists"
        json: true
        body:
          name: 'test list'
      , (err, res, body) ->
        body.name.should.equal 'test list'
        res.statusCode.should.equal 201
        done()

