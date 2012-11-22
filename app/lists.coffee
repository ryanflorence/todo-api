lists = {}

uniqueID = do ->
  c = 0
  -> ++c

module.exports =

  create: (name) ->
    id = uniqueID()
    lists[id] =
      name: name
      id: id
      items: {}

    # kill it off in a week or whatever ENV says
    setTimeout =>
      @destroy id
    , parseInt(process.env.LIST_LIFESPAN, 10) or 604800000

    lists[id]

  read: (id) ->
    if list = lists[id]
      items = (item for itemID, item of list.items)
      name: list.name
      items: items
      id: list.id
    else
      false

  destroy: (id) ->
    if lists[id]?
      delete lists[id]
    else
      false

  update: (id, newName) ->
    if list = lists[id]
      list.name = newName
      @read id
    else
      false

  index: ->
    {id: parseInt(id), name: name} for id, {name} of lists

  createItem: (listID, item) ->
    if list = lists[listID]
      item.id = uniqueID()
      list.items[item.id] = item
    else
      false

  deleteItem: (listID, itemID) ->
    if lists[listID]?.items[itemID]?
      delete lists[listID].items[itemID]
    else
      false

  readItem: (listID, itemID) ->
    lists[listID]?.items[itemID] or false

  updateItem: (listID, itemID, updates) ->
    list = lists[listID]
    return false unless list

    item = list.items[itemID]
    return false unless item

    # make sure we don't corrupt anything
    delete item[key] for key in ['path', 'id']

    item[key] = value for key, value of updates
    item

  raw: ->
    lists

