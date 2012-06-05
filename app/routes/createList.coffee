lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  list = lists.create req.body.name
  res.json list, 201

