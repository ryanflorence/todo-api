lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  try
    list = lists.read params.list_id
    res.json {list}
  catch error
    res.json error.toString(), 404

