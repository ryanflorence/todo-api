lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  try
    lists.deleteItem params.item_id
    res.json 'item deleted'
  catch error
    res.json error.toString(), 404

