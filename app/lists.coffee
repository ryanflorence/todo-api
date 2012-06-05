crypto = require 'crypto'

lists = {}

uniqueID = do ->
  c = 0
  ->
    c++
    crypto.createHmac('sha1', 'whatevz')
      .update(c.toString())
      .digest('hex')

module.exports =

  create: (name) ->
    id = uniqueID()
    list = lists[id] = {}
    list.name = name
    list.items = {}
    # kill it off in a week or whatever ENV says
    setTimeout =>
      @destroy id
    , parseInt(process.env.LIST_LIFESPAN, 10) or 604800000
    list

  read: (id) ->
    lists[id] or false

  destroy: (id) ->
    if lists[id]?
      delete lists[id]
    else
      false

  update: (id, newName) ->
    lists[id].name = newName

  index: ->
    {id, name} for id, {name} of lists

  createItem: (listID, item) ->
    if lists[listID]
      item.id = uniqueID()
      lists.items[listID].items[item.id] = item
    else
      false

  deleteItem: (listID, itemID) ->
    if lists[listID]?.items[itemID]?
      delete lists[listID].items[itemID]
    else
      false

  getItem: (listID, itemID) ->
    lists[listID]?.items[itemID]? or false

  updateItem: (listID, itemID, item) ->
    list = lists[listID]
    return false unless list

    item = list.items[itemID]
    return false unless item

    item[key] = value for key, value of item
