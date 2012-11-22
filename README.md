TODO API!
=========

You love your Todo demos. Now you have an API to throw in the mix like a
grown up.

Find it on heroku (for now) at [http://high-robot-9464.herokuapp.com/][u]

RESTful API
===========

POST /lists
-----------

Creates a new lists.

### body

- `name` - The lists name

### response

```javascript
{
  list: {
    id: <id>,
    name: <name>
  }
}
```

### notes

All lists are public and destroyed when the server is restarted, or after a week.

GET /lists
----------

Gets all lists.

### response

```javascript
{
  lists: [
    {
      id: <id>,
      name: <name>
    },
    ...
  ]
}
```

GET /lists/:list_id
------------------

Gets a list by ID with embedded items.

### response

```javascript
{
  list: {
    id: <id>,
    name: <name>,
    items: [item]
  }
}
```

DELETE /lists/:list_id
---------------------

Deletes a list.

### response

`list deleted`

PUT /lists/:list_id
------------------

Updates a list.

### body

- `name` - The list's new name

### response

```javascript
{
  list: {
    id: <id>,
    name: <name>
  }
}
```

POST /items
-----------

Creates an item in a list.

### body

Typically:

- `list_id` - The id to the list the item belongs to
- `description` - Description of the todo item
- `complete` - boolean if the item is complete or not

However, there is no schema at all, so you can store anything you want
in an item, just make sure you send a `list_id`.

### response

```javascript
{
  item: {
    id: <id>,
    description: <description>
    complete: <true/false>
    ...
  }
}
```

GET /items/:item_id
-------------------

Gets a list item.

### response

```javascript
{
  item: {
    id: <id>,
    description: <description>
    complete: <true/false>
    ...
  }
}
```

DELETE /items/:item_id
----------------------

Removes a list item.

### response

```javascript
'item deleted'
```

PUT /items/:item_id
-------------------

Updates a list item.

### body

Typically:

- `description` - Description of the todo item
- `complete` - boolean if the item is complete or not

However, there is no schema at all, so you can store anything you want
in an item.

### response

```javascript
{
  item: {
    id: <id>,
    path: <path relative to host>
    description: <description>
    complete: <true/false>
    ...
  }
}
```

Contributing
============

Run tests with `mocha test`.

  [api]:https://github.com/rpflorence/todo-api/blob/master/test/api.coffee
  [u]:http://high-robot-9464.herokuapp.com/

