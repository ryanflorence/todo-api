lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  try
    item = lists.updateItem params.item_id, body.item
    res.json {item}
  catch error
    res.json error.toString(), 404

