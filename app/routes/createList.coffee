lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  list = lists.create req.body.list
  res.json
    list:
      name: list.name
      id: list.id
  , 201

