lists = require "#{__dirname}/../lists"

module.exports = (req, res) ->
  if list = lists.update req.params.listID, req.body.name
    res.json list
  else
    res.json 'list not found', 404

