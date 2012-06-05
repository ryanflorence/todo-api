lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  if lists.deleteItem params.listID, params.itemID
    res.json 'item deleted'
  else
    res.json 'list or item not found', 404

