lists = require "#{__dirname}/../lists"

module.exports = ({params, body}, res) ->
  lists.updateItem params.listID, params.itemID, body.item

