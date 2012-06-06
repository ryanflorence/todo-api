lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  item = lists.createItem params.listID, body.item

  if item
    item.path = "/lists/#{params.listID}/items/#{item.id}" #TODO: need a real href
    res.json item, 201
  else
    res.json "list #{req.params.list} not found", 404

