lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  if item = lists.updateItem params.listID, params.itemID, body.item
    res.json item
  else
    res.json 'list or item not found', 404

