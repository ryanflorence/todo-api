lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  if item = lists.getItem params.listID, params.itemID
    res.json item
  else
    res.json 'item not found', 404

