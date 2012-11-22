lists = require "#{__dirname}/../lists"

module.exports = ({params}, res) ->
  try
    lists.destroy params.list_id
    res.json 'list deleted'
  catch error
    res.json error.toString(), 404
