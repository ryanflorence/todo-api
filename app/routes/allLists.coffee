lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  res.json lists: lists.index()

