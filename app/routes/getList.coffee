lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  if list = lists.read params.listID
    res.json list
  else
    res.json 'list not found', 404

