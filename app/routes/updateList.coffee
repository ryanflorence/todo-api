lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  try
    list = lists.update req.params.list_id, req.body.name
    res.json {list}
  catch error
    res.json error.toString(), 404

