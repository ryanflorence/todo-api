lists = {}
items = {}

uniqueID = do ->
  c = 0
  -> ++c

chuck = (type, id) ->
  throw new Error "#{type} with id #{id} not found."

module.exports =

  create: (list) ->
    id = uniqueID()
    lists[id] =
      name: list.name
      id: id
      items: {}

    # kill it off in a week or whatever ENV says
    setTimeout =>
      @destroy id
    , parseInt(process.env.LIST_LIFESPAN, 10) or 604800000

    lists[id]

  read: (id) ->
    if list = lists[id]
      items = (item for item_id, item of list.items)
      name: list.name
      items: items
      id: list.id
    else
      chuck 'list', id

  destroy: (id) ->
    if lists[id]?
      delete lists[id]
    else
      chuck 'list', id

  update: (id, newName) ->
    if list = lists[id]
      list.name = newName
      @read id
    else
      chuck 'list', id

  index: ->
    {id: parseInt(id), name: name} for id, {name} of lists

  createItem: (item) ->
    if list = lists[item.list_id]
      item.id = uniqueID()
      list.items[item.id] = item
      items[item.id] = item
    else
      chuck 'list', list_id

  deleteItem: (item_id) ->
    if item = items[item_id]
      delete lists[item.list_id].items[item.id]
      delete items[item.id]
    else
      chuck 'item', item_id

  readItem: (item_id) ->
    items[item_id] ? chuck 'item', item_id

  updateItem: (item_id, updates) ->
    item = items[item_id]
    chuck 'item', item_id unless item?

    # make sure we don't corrupt anything
    delete item[key] for key in ['path', 'id']

    item[key] = value for key, value of updates
    item

  raw: ->
    lists

