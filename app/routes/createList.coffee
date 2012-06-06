lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  list = lists.create req.body.name
  list.path = "/lists/#{list.id}" #TODO: need a real href
  res.json {name: list.name, id: list.id, path: list.path}, 201

