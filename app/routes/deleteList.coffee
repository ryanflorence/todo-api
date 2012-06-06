lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  if lists.destroy params.listID
    res.json 'list deleted'
  else
    res.json 'list not found', 404
