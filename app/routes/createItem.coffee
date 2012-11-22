lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  try
    item = lists.createItem body.item
    res.json {item}, 201
  catch error
    res.json error.toString(), 404

