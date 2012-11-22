lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  try
    item = lists.readItem params.item_id
    res.json {item}
  catch error
    res.json error.toString(), 404

