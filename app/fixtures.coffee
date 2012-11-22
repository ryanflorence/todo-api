lists = require "#{__dirname}/lists"
exports.load = ->
  list = lists.create name: 'Christmas List'
  lists.createItem
    list_id: list.id
    description: '"Barbie Nutcracker" on blue ray'
    complete: false
  lists.createItem
    list_id: list.id
    description: 'Barbie Dream House'
    complete: true
  lists.createItem
    list_id: list.id
    description: '"Meet The Fairies" DVD'
    complete: false

