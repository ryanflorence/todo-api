lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  item = lists.createItem params.listID, body.item

  if item
    res.json item, 201
  else
    res.json "list #{req.params.list} not found", 404

